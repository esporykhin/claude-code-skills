# Analytics

- Category key: `analytics`
- Methods in local catalog: `7`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getAverageDeliveryTime` | `POST` | `/v1/analytics/average-delivery-time` | `scripts/methods/analytics/get-average-delivery-time.sh` | Получить аналитику по среднему времени доставки |
| `getAverageDeliveryTimeDetails` | `POST` | `/v1/analytics/average-delivery-time/details` | `scripts/methods/analytics/get-average-delivery-time-details.sh` | Получить детальную аналитику по среднему времени доставки |
| `getAverageDeliveryTimeSummary` | `POST` | `/v1/analytics/average-delivery-time/summary` | `scripts/methods/analytics/get-average-delivery-time-summary.sh` | Получить общую аналитику по среднему времени доставки |
| `getManageStocks` | `POST` | `/v1/analytics/manage/stocks` | `scripts/methods/analytics/get-manage-stocks.sh` | Управление остатками |
| `getAnalyticsStocks` | `POST` | `/v1/analytics/stocks` | `scripts/methods/analytics/get-analytics-stocks.sh` | Получить аналитику по остаткам |
| `getStocksTurnover` | `POST` | `/v1/analytics/turnover/stocks` | `scripts/methods/analytics/get-stocks-turnover.sh` | Оборачиваемость товара |
| `getStockOnWarehouses` | `POST` | `/v2/analytics/stock_on_warehouses` | `scripts/methods/analytics/get-stock-on-warehouses.sh` | Отчёт по остаткам и товарам |
