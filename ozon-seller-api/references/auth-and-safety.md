# Auth and Safety

## Required Headers

- `Client-Id: <OZON_CLIENT_ID>`
- `Api-Key: <OZON_API_KEY>`
- `Content-Type: application/json`

## Environment Variables

- `OZON_CLIENT_ID` -> required
- `OZON_API_KEY` -> required
- `OZON_SELLER_BASE_URL` -> optional, default `https://api-seller.ozon.ru`

## Safe Execution Pattern

1. Сначала read-метод.
2. Потом маленький write-пакет на 1 объект.
3. Потом bulk-операция, если ответ и валидация корректны.

## Payload Policy

- Если schema уже понятна, передавай `--data '{"...": "..."}'`.
- Если payload большой, используй `--file payload.json`.
- Для POST/PUT/DELETE без обязательного тела можно использовать `--empty`.
- Если schema неясна, сначала открой category reference или source markdown.

## Debugging

- Ищи метод: `./scripts/ozon-find-method.sh "<query>"`
- Raw-вызов: `./scripts/ozon-request.sh METHOD /path --data ...`
- E2E smoke: `./tests/e2e.sh`
