import { AwsClient } from "aws4fetch";

interface Env {
  B2_ENDPOINT: string;
  B2_BUCKET: string;
  B2_REGION: string;
  B2_KEY_ID: string;
  B2_APPLICATION_KEY: string;
  SUPABASE_URL: string;
  SUPABASE_ANON_KEY: string;
  SUPABASE_SERVICE_ROLE_KEY: string;
}

function corsHeaders(origin: string): HeadersInit {
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Methods": "GET, PUT, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Content-Length, Range, Accept-Ranges, ETag, Authorization",
    "Access-Control-Expose-Headers": "Content-Length, Content-Range, Accept-Ranges, ETag",
    "Access-Control-Max-Age": "86400",
  };
}

async function checkDocumentAuthorization(
  env: Env,
  objectPath: string,
  authHeader: string | null
): Promise<boolean> {
  // 1. Check Authorization header format
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return false;
  }

  const token = authHeader.substring(7); // Remove 'Bearer ' prefix
   
  try {
    // Check if it's a document PDF path: documents/{document_id}.pdf
    const documentPathMatch = objectPath.match(/^documents\/(.+)\.pdf$/);
    if (documentPathMatch) {
      const documentId = documentPathMatch[1];
      return await checkDocumentAccess(env, documentId, token);
    }

    // Check if it's a scan page path: pages/{document_id}/{page_order}.jpg
    const scanPathMatch = objectPath.match(/^pages\/(.+)\/\d+\.jpg$/);
    if (scanPathMatch) {
      // Query scan_pages to verify this path exists and get its document_id
      const scanPageResponse = await fetch(
        `${env.SUPABASE_URL}/rest/v1/scan_pages?file_path=eq.${encodeURIComponent(objectPath)}&select=document_id`,
        {
          headers: {
            'apikey': env.SUPABASE_ANON_KEY,
            'Authorization': `Bearer ${token}`,
          },
        }
      );

      if (!scanPageResponse.ok) {
        return false;
      }

      const scanPages = await scanPageResponse.json();
      if (!Array.isArray(scanPages) || scanPages.length === 0) {
        return false; // Path not found in scan_pages
      }

      const documentId = scanPages[0].document_id as string;
      return await checkDocumentAccess(env, documentId, token);
    }

    // If neither pattern matches, fall back to checking exact file_path in documents
    const response = await fetch(
      `${env.SUPABASE_URL}/rest/v1/documents?file_path=eq.${encodeURIComponent(objectPath)}&select=id`,
      {
        headers: {
          'apikey': env.SUPABASE_ANON_KEY,
          'Authorization': `Bearer ${token}`,
        },
      }
    );

    if (!response.ok) {
      return false;
    }

    const documents = await response.json();
    return Array.isArray(documents) && documents.length > 0;
  } catch (error) {
    console.error('Authorization check error:', error);
    return false;
  }
}

async function checkDocumentAccess(env: Env, documentId: string, token: string): Promise<boolean> {
  const response = await fetch(
    `${env.SUPABASE_URL}/rest/v1/documents?id=eq.${encodeURIComponent(documentId)}&select=id`,
    {
      headers: {
        'apikey': env.SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${token}`,
      },
    }
  );

  if (!response.ok) {
    return false;
  }

  const documents = await response.json();
  return Array.isArray(documents) && documents.length > 0;
}

async function handleDeleteAccount(request: Request, env: Env): Promise<Response> {
  const origin = request.headers.get("Origin") || "*";
  const cors = corsHeaders(origin);

  if (request.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }

  if (request.method !== "DELETE") {
    return new Response(JSON.stringify({ error: "Method not allowed" }), {
      status: 405,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }

  const authHeader = request.headers.get("Authorization");
  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return new Response(JSON.stringify({ error: "Unauthorized: missing or invalid Authorization header" }), {
      status: 401,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }

  const token = authHeader.substring(7);

  try {
    // Step 1: Resolve the caller's own user ID using the Bearer token
    const userResponse = await fetch(
      `${env.SUPABASE_URL}/auth/v1/user`,
      {
        headers: {
          'apikey': env.SUPABASE_ANON_KEY,
          'Authorization': `Bearer ${token}`,
        },
      }
    );

    if (!userResponse.ok) {
      const errorText = await userResponse.text();
      console.error('Failed to resolve user:', errorText);
      return new Response(JSON.stringify({ error: "Failed to authenticate user" }), {
        status: 401,
        headers: { "Content-Type": "application/json", ...cors },
      });
    }

    const userData = await userResponse.json();
    const userId = userData.id as string;

    if (!userId) {
      return new Response(JSON.stringify({ error: "Could not determine user ID" }), {
        status: 400,
        headers: { "Content-Type": "application/json", ...cors },
      });
    }

    // Step 2: Delete the user using the service role key (admin API)
    const deleteResponse = await fetch(
      `${env.SUPABASE_URL}/auth/v1/admin/users/${encodeURIComponent(userId)}`,
      {
        method: 'DELETE',
        headers: {
          'apikey': env.SUPABASE_SERVICE_ROLE_KEY,
          'Authorization': `Bearer ${env.SUPABASE_SERVICE_ROLE_KEY}`,
        },
      }
    );

    if (!deleteResponse.ok) {
      const errorText = await deleteResponse.text();
      console.error('Failed to delete user:', errorText);
      return new Response(JSON.stringify({ error: "Failed to delete account" }), {
        status: 500,
        headers: { "Content-Type": "application/json", ...cors },
      });
    }

    return new Response(JSON.stringify({ success: true }), {
      status: 200,
      headers: { "Content-Type": "application/json", ...cors },
    });
  } catch (error) {
    console.error('Delete account error:', error);
    return new Response(JSON.stringify({ error: "Internal server error" }), {
      status: 500,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }
}

async function handleRequest(request: Request, env: Env): Promise<Response> {
  const url = new URL(request.url);
  const origin = request.headers.get("Origin") || "*";
  const cors = corsHeaders(origin);

  if (request.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
  }

  // Handle DELETE /account route
  if (url.pathname === "/account" && request.method === "DELETE") {
    return handleDeleteAccount(request, env);
  }

  if (url.pathname === "/" || url.pathname === "/health") {
    return new Response(JSON.stringify({ status: "ok", service: "shelf-b2-proxy" }), {
      status: 200,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }

  if (!url.pathname.startsWith("/files/")) {
    return new Response(JSON.stringify({ error: "Not found" }), {
      status: 404,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }

  const objectPath = url.pathname.slice("/files/".length);
  if (!objectPath) {
    return new Response(JSON.stringify({ error: "Object path required" }), {
      status: 400,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }

  const method = request.method;
  const requestHeaders: Record<string, string> = {};

  const contentType = request.headers.get("Content-Type");
  if (contentType) {
    requestHeaders["Content-Type"] = contentType;
  }
  const contentLength = request.headers.get("Content-Length");
  if (contentLength) {
    requestHeaders["Content-Length"] = contentLength;
  }
  const rangeHeader = request.headers.get("Range");
  if (rangeHeader) {
    requestHeaders["Range"] = rangeHeader;
  }

  const body = method === "GET" || method === "HEAD" ? null : await request.arrayBuffer();
  const authHeader = request.headers.get("Authorization");

  // AUTHORIZATION CHECK - MUST PASS BEFORE PROCEEDING
  const isAuthorized = await checkDocumentAuthorization(env, objectPath, authHeader);
  if (!isAuthorized) {
    // 5. Return 403 for both "no permission" and "object doesn't exist" cases
    return new Response(JSON.stringify({ error: "Forbidden" }), {
      status: 403,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }

  try {
    const endpointUrl = new URL(env.B2_ENDPOINT);
    const virtualHostedUrl = `https://${env.B2_BUCKET}.${endpointUrl.host}/${objectPath}`;

    const awsClient = new AwsClient({
      accessKeyId: env.B2_KEY_ID,
      secretAccessKey: env.B2_APPLICATION_KEY,
      region: env.B2_REGION,
      service: "s3",
    });

    const signedRequest = await awsClient.sign(new Request(virtualHostedUrl, {
      method,
      headers: requestHeaders,
      body: body as BodyInit | null,
    }));

    const isReadRequest = method === "GET" || method === "HEAD";
    const response = await fetch(signedRequest, {
      cf: isReadRequest
        ? {
            cacheTtl: 3600,
            cacheEverything: true,
          }
        : undefined,
    });

    const responseHeaders = new Headers(cors);

    const headersToPreserve = [
      "Content-Type",
      "Content-Length",
      "Content-Range",
      "Accept-Ranges",
      "ETag",
      "Last-Modified",
      "Cache-Control",
    ];

    for (const header of headersToPreserve) {
      const value = response.headers.get(header);
      if (value) {
        responseHeaders.set(header, value);
      }
    }

    if (method === "GET" && response.ok) {
      responseHeaders.set("Cache-Control", "public, max-age=3600, stale-while-revalidate=86400");
    }

    const responseBody = method === "HEAD" ? null : response.body;
    return new Response(responseBody, {
      status: response.status,
      statusText: response.statusText,
      headers: responseHeaders,
    });
  } catch (error) {
    console.error("B2 proxy error:", error);
    return new Response(JSON.stringify({ error: "Internal server error" }), {
      status: 500,
      headers: { "Content-Type": "application/json", ...cors },
    });
  }
}

export default {
  async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
    return handleRequest(request, env);
  },
};