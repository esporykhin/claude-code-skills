# Invoice

- Category key: `invoice`
- Methods in local catalog: `4`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `deleteInvoice` | `DELETE` | `/v1/invoice/delete` | `scripts/methods/invoice/delete-invoice.sh` | Удалить ссылку на счёт-фактуру |
| `uploadInvoiceFile` | `POST` | `/v1/invoice/file/upload` | `scripts/methods/invoice/upload-invoice-file.sh` | Загрузка счёта-фактуры |
| `createOrUpdateInvoice` | `POST` | `/v2/invoice/create-or-update` | `scripts/methods/invoice/create-or-update-invoice.sh` | Создать или изменить счёт-фактуру |
| `getInvoice` | `GET` | `/v2/invoice/get` | `scripts/methods/invoice/get-invoice.sh` | Получить информацию о счёте-фактуре |
