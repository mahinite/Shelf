import { AwsClient } from "aws4fetch";

interface Env {
  B2_ENDPOINT: string;
  B2_BUCKET: string;
  B2_REGION: string;
  B2_KEY_ID: string;
  B2_APPLICATION_KEY: string;
  SUPABASE_URL: string;
  SUPABASE_ANON_KEY: string;
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
    // 3. Call Supabase REST API with user's token
    const response = await fetch(
      `${env.SUPABASE_URL}/rest/v1/documents?file_path=eq.${encodeURIComponent(objectPath)}&select=id`,
      {
        headers: {
          'apikey': env.SUPABASE_ANON_KEY,
          'Authorization': `Bearer ${token}`,
        },
      }
    );

    // 5. If non-200 status, return false (will become 403)
    if (!response.ok) {
      return false;
    }

    // Parse response - expecting array of documents
    const documents = await response.json();
    
    // 5. If empty array, return false (will become 403)
    //    If at least one row, return true (will proceed to B2)
    return Array.isArray(documents) && documents.length > 0;
    
  } catch (error) {
    // 5. If fails for any reason, return false (will become 403)
    console.error('Authorization check error:', error);
    return false;
  }
}

async function handleRequest(request: Request, env: Env): Promise<Response> {
  const url = new URL(request.url);
  const origin = request.headers.get("Origin") || "*";
  const cors = corsHeaders(origin);

  if (request.method === "OPTIONS") {
    return new Response(null, { status: 204, headers: cors });
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