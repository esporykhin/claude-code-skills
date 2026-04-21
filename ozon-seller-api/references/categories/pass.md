# Pass

- Category key: `pass`
- Methods in local catalog: `4`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getPassList` | `POST` | `/v1/pass/list` | `scripts/methods/pass/get-pass-list.sh` | Список пропусков |
| `createReturnPass` | `POST` | `/v1/return/pass/create` | `scripts/methods/pass/create-return-pass.sh` | Создать пропуск для возврата |
| `deleteReturnPass` | `DELETE` | `/v1/return/pass/delete` | `scripts/methods/pass/delete-return-pass.sh` | Удалить пропуск для возврата |
| `updateReturnPass` | `POST` | `/v1/return/pass/update` | `scripts/methods/pass/update-return-pass.sh` | Обновить пропуск для возврата |
