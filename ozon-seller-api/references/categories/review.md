# Review

- Category key: `review`
- Methods in local catalog: `7`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `changeStatus` | `POST` | `/v1/review/change-status` | `scripts/methods/review/change-status.sh` | Изменить статус отзывов |
| `createComment` | `POST` | `/v1/review/comment/create` | `scripts/methods/review/create-comment.sh` | Оставить комментарий на отзыв |
| `deleteComment` | `DELETE` | `/v1/review/comment/delete` | `scripts/methods/review/delete-comment.sh` | Удалить комментарий на отзыв |
| `getCommentList` | `POST` | `/v1/review/comment/list` | `scripts/methods/review/get-comment-list.sh` | Список комментариев на отзыв |
| `getCount` | `POST` | `/v1/review/count` | `scripts/methods/review/get-count.sh` | Количество отзывов по статусам |
| `getInfo` | `POST` | `/v1/review/info` | `scripts/methods/review/get-info.sh` | Получить информацию об отзыве |
| `getList` | `POST` | `/v1/review/list` | `scripts/methods/review/get-list.sh` | Получить список отзывов |
