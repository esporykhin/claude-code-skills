# Authentication & Setup

## Base URL

```
https://mpstats.io/api/
```

All endpoint paths in this documentation are relative to this base URL.

## API Token

Obtain your token at https://mpstats.io/userpanel in the "API token" block.

The token is automatically regenerated when:
- You change your password
- You click "Change API token" in settings

## Authentication Methods

### Header (recommended)

```
X-Mpstats-TOKEN: 5a2a5f0e538dd5.6691914852255446e23a9bcac46ee5255625f5d5
```

### Query parameter (alternative)

```
&auth-token=5a2a5f0e538dd5.6691914852255446e23a9bcac46ee5255625f5d5
```

## Required Headers

Every request must include:
```
X-Mpstats-TOKEN: <token>
Content-Type: application/json
```

## Response Codes

| Code | Meaning |
|------|---------|
| 200  | Success |
| 202  | Request accepted but not yet complete — retry later |
| 401  | Authorization error — invalid or missing token |
| 429  | Rate limit exceeded — see `message` field for details, `Retry-After` header for wait time in seconds |
| 500  | Internal server error — see `message` field for details |

## Rate Limits

Rate limits depend on your subscription plan. On 429:
- Check the `message` field for details
- Check the `Retry-After` response header for wait time in seconds
- Retry after that time

To check remaining API limit quota: `GET user/report_api_limit`
See `account.md` for details.

## Quick Example (cURL)

```bash
curl --location --request GET 'https://mpstats.io/api/wb/get/categories' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

## Quick Example (TypeScript)

```typescript
const BASE_URL = 'https://mpstats.io/api';
const TOKEN = process.env.MPSTATS_TOKEN!;

const headers = {
  'X-Mpstats-TOKEN': TOKEN,
  'Content-Type': 'application/json',
};

async function mpstatsGet(path: string) {
  const res = await fetch(`${BASE_URL}/${path}`, { headers });
  if (!res.ok) throw new Error(`MPSTATS API error: ${res.status}`);
  return res.json();
}

async function mpstatsPost(path: string, body: object) {
  const res = await fetch(`${BASE_URL}/${path}`, {
    method: 'POST',
    headers,
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`MPSTATS API error: ${res.status}`);
  return res.json();
}
```
