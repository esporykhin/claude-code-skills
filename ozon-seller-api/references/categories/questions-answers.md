# Questions Answers

- Category key: `questions-answers`
- Methods in local catalog: `8`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `createAnswer` | `POST` | `/v1/question/answer/create` | `scripts/methods/questions-answers/create-answer.sh` | Создать ответ на вопрос |
| `deleteAnswer` | `DELETE` | `/v1/question/answer/delete` | `scripts/methods/questions-answers/delete-answer.sh` | Удалить ответ на вопрос |
| `getAnswerList` | `POST` | `/v1/question/answer/list` | `scripts/methods/questions-answers/get-answer-list.sh` | Список ответов на вопрос |
| `changeQuestionStatus` | `POST` | `/v1/question/change-status` | `scripts/methods/questions-answers/change-question-status.sh` | Изменить статус вопросов |
| `getQuestionCount` | `POST` | `/v1/question/count` | `scripts/methods/questions-answers/get-question-count.sh` | Количество вопросов по статусам |
| `getQuestionInfo` | `POST` | `/v1/question/info` | `scripts/methods/questions-answers/get-question-info.sh` | Информация о вопросе |
| `getQuestionList` | `POST` | `/v1/question/list` | `scripts/methods/questions-answers/get-question-list.sh` | Список вопросов |
| `getTopQuestionedProducts` | `POST` | `/v1/question/top-sku` | `scripts/methods/questions-answers/get-top-questioned-products.sh` | Товары с наибольшим количеством вопросов |
