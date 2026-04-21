# Report

- Category key: `report`
- Methods in local catalog: `12`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getRemovalFromStockReport` | `POST` | `/v1/removal/from-stock/list` | `scripts/methods/report/get-removal-from-stock-report.sh` | Отчёт по вывозу и утилизации со стока FBO |
| `getRemovalFromSupplyReport` | `POST` | `/v1/removal/from-supply/list` | `scripts/methods/report/get-removal-from-supply-report.sh` | Отчёт по вывозу и утилизации с поставки FBO |
| `createDiscountedReport` | `POST` | `/v1/report/discounted/create` | `scripts/methods/report/create-discounted-report.sh` | Отчёт об уценённых товарах |
| `getReportInfo` | `POST` | `/v1/report/info` | `scripts/methods/report/get-report-info.sh` | Информация об отчёте |
| `getReportList` | `POST` | `/v1/report/list` | `scripts/methods/report/get-report-list.sh` | Список отчётов |
| `postReportMarkedProductsSalesCreate` | `POST` | `/v1/report/marked-products-sales/create` | `scripts/methods/report/post-report-marked-products-sales-create.sh` | Сгенерировать отчёт по продажам товаров с маркировкой |
| `postReportPlacementByProductsCreate` | `POST` | `/v1/report/placement/by-products/create` | `scripts/methods/report/post-report-placement-by-products-create.sh` | Получить отчёт о стоимости размещения по товарам |
| `postReportPlacementBySuppliesCreate` | `POST` | `/v1/report/placement/by-supplies/create` | `scripts/methods/report/post-report-placement-by-supplies-create.sh` | Получить отчёт о стоимости размещения по поставкам |
| `createPostingsReport` | `POST` | `/v1/report/postings/create` | `scripts/methods/report/create-postings-report.sh` | Отчёт об отправлениях |
| `createProductsReport` | `POST` | `/v1/report/products/create` | `scripts/methods/report/create-products-report.sh` | Отчёт по товарам |
| `createStockByWarehouseReport` | `POST` | `/v1/report/warehouse/stock` | `scripts/methods/report/create-stock-by-warehouse-report.sh` | Отчёт об остатках на FBS-складе |
| `createReturnsReport` | `POST` | `/v2/report/returns/create` | `scripts/methods/report/create-returns-report.sh` | Отчёт о возвратах |
