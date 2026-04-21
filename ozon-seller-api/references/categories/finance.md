# Finance

- Category key: `finance`
- Methods in local catalog: `12`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postFinanceBalance` | `POST` | `/v1/finance/balance` | `scripts/methods/finance/post-finance-balance.sh` | Получить отчёт о балансе |
| `getFinanceCashFlowStatement` | `POST` | `/v1/finance/cash-flow-statement/list` | `scripts/methods/finance/get-finance-cash-flow-statement.sh` | Финансовый отчёт |
| `createCompensationReport` | `POST` | `/v1/finance/compensation` | `scripts/methods/finance/create-compensation-report.sh` | Отчёт о компенсациях |
| `createDecompensationReport` | `POST` | `/v1/finance/decompensation` | `scripts/methods/finance/create-decompensation-report.sh` | Отчёт о декомпенсациях |
| `createDocumentB2BSalesReport` | `POST` | `/v1/finance/document-b2b-sales` | `scripts/methods/finance/create-document-b2-b-sales-report.sh` | Реестр продаж юридическим лицам |
| `createDocumentB2BSalesJSONReport` | `POST` | `/v1/finance/document-b2b-sales/json` | `scripts/methods/finance/create-document-b2-b-sales-json-report.sh` | Реестр продаж юридическим лицам в JSON-формате |
| `createMutualSettlementReport` | `POST` | `/v1/finance/mutual-settlement` | `scripts/methods/finance/create-mutual-settlement-report.sh` | Отчёт о взаиморасчётах |
| `getProductsBuyout` | `POST` | `/v1/finance/products/buyout` | `scripts/methods/finance/get-products-buyout.sh` | Отчёт о выкупленных товарах |
| `getRealizationReportPosting` | `POST` | `/v1/finance/realization/posting` | `scripts/methods/finance/get-realization-report-posting.sh` | Позаказный отчёт о реализации товаров |
| `getRealizationReportV2` | `POST` | `/v2/finance/realization` | `scripts/methods/finance/get-realization-report-v2.sh` | Отчёт о реализации товаров (версия 2) |
| `getTransactionList` | `POST` | `/v3/finance/transaction/list` | `scripts/methods/finance/get-transaction-list.sh` | Список транзакций |
| `getTransactionTotals` | `POST` | `/v3/finance/transaction/totals` | `scripts/methods/finance/get-transaction-totals.sh` | Суммы транзакций |
