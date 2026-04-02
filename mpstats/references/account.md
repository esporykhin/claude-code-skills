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

Use script wrapper: `scripts/account-limits.sh`.
