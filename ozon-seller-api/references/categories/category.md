# Category

- Category key: `category`
- Methods in local catalog: `4`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getCategoryAttributes` | `POST` | `/v1/description-category/attribute` | `scripts/methods/category/get-category-attributes.sh` | Список характеристик категории |
| `getCategoryAttributeValues` | `POST` | `/v1/description-category/attribute/values` | `scripts/methods/category/get-category-attribute-values.sh` | Справочник значений характеристики |
| `searchCategoryAttributeValues` | `POST` | `/v1/description-category/attribute/values/search` | `scripts/methods/category/search-category-attribute-values.sh` | Поиск по справочным значениям характеристики |
| `getCategoryTree` | `POST` | `/v1/description-category/tree` | `scripts/methods/category/get-category-tree.sh` | Дерево категорий и типов товаров |
