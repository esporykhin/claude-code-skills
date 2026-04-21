# Brand

- Category key: `brand`
- Methods in local catalog: `1`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getCertificationList` | `POST` | `/v1/brand/company-certification/list` | `scripts/methods/brand/get-certification-list.sh` | Список сертифицируемых брендов |
