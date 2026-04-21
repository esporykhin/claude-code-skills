---
name: ozon-seller-api
description: Ozon Seller API skill with bash wrappers, method search, category references, and raw requests. Use when working with Ozon Seller API products, prices, stocks, warehouses, FBS, FBO, FBP, returns, analytics, finance, chats, notifications, or Ozon Logistics.
---

# Ozon Seller API

Короткий рабочий skill для Ozon Seller API.

## Coverage

- Категорий в каталоге: `38`
- Bash wrappers: `409`

## Workflow

1. Если меняешь скрипты, сначала запусти `./tests/e2e.sh`.
2. Если не знаешь, где метод, открой `references/INDEX.md`.
3. Если задача описана по-бизнесовому, а не именем метода, открой `references/SCENARIOS.md`.
4. Если знаешь домен, открой `references/categories/<category>.md`.
5. Для поиска используй `./scripts/ozon-find-method.sh "<query>"`.
6. Для вызова используй wrapper из `scripts/methods/...`.
7. Если wrapper не подходит, используй `./scripts/ozon-request.sh`.

## Standard Commands

```bash
OZON_CLIENT_ID=... OZON_API_KEY=... ./scripts/ozon-request.sh POST /v1/roles --empty
./scripts/ozon-find-method.sh "product list"
./scripts/ozon-find-method.sh "question list"
./scripts/ozon-find-method.sh "/v2/warehouse/list"
OZON_CLIENT_ID=... OZON_API_KEY=... ./scripts/methods/product/post-product-list.sh --data '{"filter":{"visibility":"ALL"},"limit":100}'
```

## Notes

- Для write-методов сначала делай минимальный payload на 1 объект.
- Для массовых операций сначала проверь read-методом, что именно собираешься менять.
- Если payload неизвестен, смотри category reference и не тащи весь каталог в контекст.
- Для ориентации по задаче сначала лучше читать `references/SCENARIOS.md`, а не весь каталог категорий подряд.
