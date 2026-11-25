Yeah — based on that screenshot, your Worker is reaching B2 successfully, but B2 is returning a 503 ServiceUnavailable during the PUT.

The important part is:

Worker PUT failed 503:
<Code>ServiceUnavailable</Code>
<Message>Service unavailable, please try again later.</Message>

That is very different from an authentication/configuration error.

What probably happened

Your architecture is roughly:

Shelf app
↓
Cloudflare Worker
↓
Backblaze B2 upload URL
↓
B2 storage

The Worker is getting all the way to the last step. B2 is essentially saying "this upload endpoint/storage service isn't available right now."

Backblaze specifically documents that 5xx responses from an upload URL should be handled by requesting a fresh upload URL and retrying. Their upload URLs point to a specific B2 storage pod, so an individual upload target can temporarily fail even when B2 itself is generally operational.

And right now, Backblaze's status page says all systems operational, so this doesn't currently look like a broad B2 outage.

The thing I'd check in your Worker

If your code does something like:

1. authorize B2
2. get_upload_url
3. PUT file to uploadUrl
4. return success

you probably need:

1.  authorize B2
2.  get_upload_url
3.  PUT file
    ↓
    5xx?
    ↓ YES
4.  get a NEW upload URL
5.  PUT file again
6.  retry a few times

Don't keep reusing the same B2 upload URL after a 503. Backblaze explicitly recommends obtaining another upload URL after a 5xx.

So if this suddenly started happening after working a few hours ago, I would not start changing your B2 credentials, bucket configuration, CORS, etc. yet. Those things generally wouldn't suddenly produce this particular response.

Also, Cloudflare itself had some incidents around September 30, including Workers build delays, but the error you're showing contains the B2-style XML ServiceUnavailable response rather than a typical Cloudflare-generated 503 page. Cloudflare's own documentation says the response body helps distinguish where a 503 originated.

One useful test

Try saving the same file again right now.

If it works on the second attempt, that's very strong evidence that you hit a transient B2 upload-pod failure.

If it keeps failing, send me your current Cloudflare Worker code for the PUT/upload portion (especially the part that calls b2_get_upload_url and uploads to B2). I can trace exactly where the retry/new-upload-URL handling needs to go.