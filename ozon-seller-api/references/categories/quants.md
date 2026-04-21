# Quants

- Category key: `quants`
- Methods in local catalog: `2`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getInfo` | `POST` | `/v1/product/quant/info` | `scripts/methods/quants/get-info.sh` | Информация об эконом-товаре |
| `getList` | `POST` | `/v1/product/quant/list` | `scripts/methods/quants/get-list.sh` | Список эконом-товаров |
