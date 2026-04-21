# Premium

- Category key: `premium`
- Methods in local catalog: `5`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getAnalyticsData` | `POST` | `/v1/analytics/data` | `scripts/methods/premium/get-analytics-data.sh` | Данные аналитики |
| `getProductQueries` | `POST` | `/v1/analytics/product-queries` | `scripts/methods/premium/get-product-queries.sh` | Получить информацию о запросах моих товаров |
| `getProductQueriesDetails` | `POST` | `/v1/analytics/product-queries/details` | `scripts/methods/premium/get-product-queries-details.sh` | Получить детализацию запросов по товару |
| `getRealizationByDay` | `POST` | `/v1/finance/realization/by-day` | `scripts/methods/premium/get-realization-by-day.sh` | Отчёт о реализации товаров за день |
| `postProductPricesDetails` | `POST` | `/v1/product/prices/details` | `scripts/methods/premium/post-product-prices-details.sh` | Получить подробную информацию о ценах товаров |
