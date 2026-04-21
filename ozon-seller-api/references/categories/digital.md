# Digital

- Category key: `digital`
- Methods in local catalog: `3`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `uploadDigitalCodes` | `POST` | `/v1/posting/digital/codes/upload` | `scripts/methods/digital/upload-digital-codes.sh` | Загрузить коды цифровых товаров для отправления |
| `getDigitalPostingsList` | `POST` | `/v1/posting/digital/list` | `scripts/methods/digital/get-digital-postings-list.sh` | Получить список отправлений |
| `updateDigitalStocks` | `POST` | `/v1/product/digital/stocks/import` | `scripts/methods/digital/update-digital-stocks.sh` | Обновить количество цифровых товаров |
