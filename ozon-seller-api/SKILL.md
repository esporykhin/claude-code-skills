---
name: ozon-seller-api
version: 1.0.0
description: "Ozon Seller API operations for marketplace automation. Use when working with Ozon seller API methods, product list, prices, stock updates, FBS/FBO postings, warehouses, reports, or direct authenticated requests to api-seller.ozon.ru."
license: MIT
metadata:
  author: evgeny
  version: "1.0.0"
---

# Ozon Seller API

Скилл для работы с Ozon Seller API через готовые shell-скрипты.

Покрывает базовые операционные сценарии:

- товары и цены;
- обновление остатков и цен;
- отправления FBS/FBO;
- список складов;
- список и статус отчётов;
- произвольные запросы к любому endpoint.

## When to Apply

- Нужно получить список товаров в Ozon (`/v2/product/list`)
- Нужно получить цены товаров (`/v4/product/info/prices`)
- Нужно обновить остатки (`/v1/product/import/stocks`)
- Нужно обновить цены (`/v1/product/import/prices`)
- Нужно получить отправления FBS/FBO (`/v3/posting/fbs/list`, `/v2/posting/fbo/list`)
- Нужно получить список складов (`/v1/warehouse/list`)
- Нужно получить список отчётов и детали отчёта (`/v1/report/list`, `/v1/report/info`)
- Нужно сделать любой другой запрос к Seller API с `Client-Id` + `Api-Key`

## Base URL & Auth

```text
Base URL: https://api-seller.ozon.ru
```

Обязательные заголовки:

- `Client-Id: <your_client_id>`
- `Api-Key: <your_api_key>`
- `Content-Type: application/json`

Подробнее: `references/auth.md`

## Documentation References

- `references/auth.md` — авторизация, переменные окружения, базовые ошибки, источники
- `references/products-and-prices.md` — товары, цены, остатки, обновление цен
- `references/postings-reports-warehouses.md` — FBS/FBO отправления, склады, отчёты

## Scripts

Готовые скрипты лежат в `scripts/`.

| Script | Purpose | Usage |
|--------|---------|-------|
| `products-list.sh` | Список товаров | `./scripts/products-list.sh ALL 100` |
| `product-prices.sh` | Информация о ценах товаров | `./scripts/product-prices.sh ALL 100` |
| `update-stocks.sh` | Обновление остатков | `./scripts/update-stocks.sh "SKU-123" 15` |
| `update-prices.sh` | Обновление цен | `./scripts/update-prices.sh "SKU-123" 1299 1599 RUB` |
| `postings-fbs-list.sh` | Список отправлений FBS | `./scripts/postings-fbs-list.sh 2026-03-01 2026-03-31` |
| `postings-fbo-list.sh` | Список отправлений FBO | `./scripts/postings-fbo-list.sh 2026-03-01 2026-03-31` |
| `warehouses-list.sh` | Список складов | `./scripts/warehouses-list.sh` |
| `report-list.sh` | Список отчётов | `./scripts/report-list.sh ALL 1 50` |
| `report-info.sh` | Информация по отчёту | `./scripts/report-info.sh <report_code>` |
| `request-raw.sh` | Произвольный запрос к endpoint | `./scripts/request-raw.sh POST /v2/product/list payload.json` |

## Which Script to Use

- Пользователь спрашивает про список товаров -> `products-list.sh`
- Пользователь спрашивает про текущие цены -> `product-prices.sh`
- Пользователь просит обновить остатки -> `update-stocks.sh`
- Пользователь просит обновить цены -> `update-prices.sh`
- Пользователь просит отправления FBS -> `postings-fbs-list.sh`
- Пользователь просит отправления FBO -> `postings-fbo-list.sh`
- Пользователь просит список складов -> `warehouses-list.sh`
- Пользователь просит отчёты или статус формирования -> `report-list.sh` + `report-info.sh`
- Нужен endpoint вне покрытых сценариев -> `request-raw.sh`

## Credentials Handling

Скрипты читают креды из:

1. Переменных окружения (`OZON_CLIENT_ID`, `OZON_API_KEY`)
2. `~/.claude/credentials.env`

Если креды отсутствуют, запроси у пользователя `OZON_CLIENT_ID` и `OZON_API_KEY` и выполни нужный скрипт с временными env-переменными.

## Notes

- Для больших выборок используй пагинацию (`limit`, `offset`, `last_id`).
- Для списков отправлений учитывай `has_next` и продолжай выгрузку следующей страницей.
- Для критичных массовых операций (остатки/цены) сначала делай тест на небольшой выборке.
