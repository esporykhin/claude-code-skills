# Account API

Endpoints for checking your account's API usage and limits.

All endpoints: `GET` to `https://mpstats.io/api/<path>`

---

## API Limit Balance

### GET user/report_api_limit
Get remaining API call quota for your current plan.

```bash
curl --location --request GET 'https://mpstats.io/api/user/report_api_limit' \
  --header 'X-Mpstats-TOKEN: YOUR_TOKEN' \
  --header 'Content-Type: application/json'
```

**Response:**
```json
{
  "available": 2500,
  "use": 38
}
```

| Field       | Type | Description |
|-------------|------|-------------|
| `available` | int  | Total API calls available on your plan |
| `use`       | int  | API calls used so far |

**Remaining calls** = `available - use`

---

## TypeScript Example

```typescript
async function getApiLimitStatus(token: string) {
  const res = await fetch('https://mpstats.io/api/user/report_api_limit', {
    headers: {
      'X-Mpstats-TOKEN': token,
      'Content-Type': 'application/json',
    },
  });
  const data = await res.json();
  return {
    available: data.available,
    used: data.use,
    remaining: data.available - data.use,
  };
}
```

## Python Example

```python
import requests

def get_api_limit(token: str):
    resp = requests.get(
        "https://mpstats.io/api/user/report_api_limit",
        headers={"X-Mpstats-TOKEN": token, "Content-Type": "application/json"},
    )
    resp.raise_for_status()
    data = resp.json()
    return {
        "available": data["available"],
        "used": data["use"],
        "remaining": data["available"] - data["use"],
    }
```
