# Seller Rating

- Category key: `seller-rating`
- Methods in local catalog: `4`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getRatingHistory` | `POST` | `/v1/rating/history` | `scripts/methods/seller-rating/get-rating-history.sh` | Получить информацию о рейтингах продавца за период |
| `postRatingIndexFbsInfo` | `POST` | `/v1/rating/index/fbs/info` | `scripts/methods/seller-rating/post-rating-index-fbs-info.sh` | Получить индекс ошибок FBS и rFBS |
| `postRatingIndexFbsPostingList` | `POST` | `/v1/rating/index/fbs/posting/list` | `scripts/methods/seller-rating/post-rating-index-fbs-posting-list.sh` | Список отправлений, которые повлияли на индекс ошибок FBS и rFBS |
| `getCurrentRatings` | `POST` | `/v1/rating/summary` | `scripts/methods/seller-rating/get-current-ratings.sh` | Получить информацию о текущих рейтингах продавца |
