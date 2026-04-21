# Receipts

- Category key: `receipts`
- Methods in local catalog: `3`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getReceiptsGet` | `GET` | `/v1/receipts/get` | `scripts/methods/receipts/get-receipts-get.sh` | Получить чек в формате PDF |
| `postReceiptsSellerList` | `POST` | `/v1/receipts/seller/list` | `scripts/methods/receipts/post-receipts-seller-list.sh` | Получить список чеков продавца |
| `postReceiptsUpload` | `POST` | `/v1/receipts/upload` | `scripts/methods/receipts/post-receipts-upload.sh` | Загрузить чек |
