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

Scripts read credentials in this order:

1. Environment variables
2. `~/.claude/credentials.env`

Supported variable names:

- `OZON_CLIENT_ID` (preferred)
- `OZON_API_KEY` (preferred)
- `OZON_SELLER_BASE_URL` (optional)

Compatibility aliases:

- `OZON_SELLER_ID`, `OZON_SELLER_CLIENT_ID`
- `OZON_SELLER_API_KEY`
- `OZON_BASE_URL`

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
