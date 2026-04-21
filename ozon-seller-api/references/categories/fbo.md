# Fbo

- Category key: `fbo`
- Methods in local catalog: `3`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getCancelReasons` | `POST` | `/v1/posting/fbo/cancel-reason/list` | `scripts/methods/fbo/get-cancel-reasons.sh` | Причины отмены отправлений по схеме FBO |
| `getPosting` | `POST` | `/v2/posting/fbo/get` | `scripts/methods/fbo/get-posting.sh` | Информация об отправлении |
| `getPostingsList` | `POST` | `/v2/posting/fbo/list` | `scripts/methods/fbo/get-postings-list.sh` | Список отправлений |
