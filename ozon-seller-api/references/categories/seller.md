# Seller

- Category key: `seller`
- Methods in local catalog: `3`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getRolesByToken` | `POST` | `/v1/roles` | `scripts/methods/seller/get-roles-by-token.sh` | Получить список ролей и методов по API-ключу |
| `postSellerInfo` | `POST` | `/v1/seller/info` | `scripts/methods/seller/post-seller-info.sh` | Информация о кабинете продавца |
| `postSellerOzonLogisticsInfo` | `POST` | `/v1/seller/ozon-logistics/info` | `scripts/methods/seller/post-seller-ozon-logistics-info.sh` | Информация о подключении Ozon Логистики |
