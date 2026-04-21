# Search Queries

- Category key: `search-queries`
- Methods in local catalog: `2`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postSearchQueriesText` | `POST` | `/v1/search-queries/text` | `scripts/methods/search-queries/post-search-queries-text.sh` | Получить список поисковых запросов по тексту |
| `postSearchQueriesTop` | `POST` | `/v1/search-queries/top` | `scripts/methods/search-queries/post-search-queries-top.sh` | Получить список популярных поисковых запросов |
