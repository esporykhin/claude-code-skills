# Ozon Seller API: Auth and Basics

## Base URL

```text
https://api-seller.ozon.ru
```

## Required Headers

Every request requires:

- `Client-Id: <your_client_id>`
- `Api-Key: <your_api_key>`
- `Content-Type: application/json`

## Credentials in This Skill

All scripts require environment variables for each run:

- `OZON_CLIENT_ID` — Client-Id from Ozon seller panel
- `OZON_API_KEY` — Api-Key from Ozon seller panel
- `OZON_SELLER_BASE_URL` (optional, default: `https://api-seller.ozon.ru`)

If credentials are missing, ask user to provide them directly and run with temporary env vars.

## Typical Error Codes

- `200` — success
- `400` — bad request payload / validation
- `403` — access denied, invalid `Client-Id` or `Api-Key`, or method not allowed for account
- `404` — method or entity not found
- `409` — conflict (business state conflict)
- `500` — server-side error

## Practical Notes

- Prefer pagination parameters (`limit`, `offset`, `last_id`) for large datasets.
- For list methods with `has_next = true`, repeat request with next cursor/offset.
- Keep request bodies minimal: send only filters you actually need.

## Sources

- Official docs hub: https://dev.ozon.ru/
- Seller API docs entry: https://docs.ozon.ru/api/seller/
- API host: https://api-seller.ozon.ru/
- Public Postman mirror (used for method contracts in this skill):
  https://www.postman.com/collections/12400166-c14fa025-46e8-43f3-8afe-70b28991ce3b
