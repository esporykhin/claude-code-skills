# Fbs Rfbs Marks

- Category key: `fbs-rfbs-marks`
- Methods in local catalog: `6`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `updateProductExemplar` | `POST` | `/v1/fbs/posting/product/exemplar/update` | `scripts/methods/fbs-rfbs-marks/update-product-exemplar.sh` | Обновить данные экземпляров |
| `postPostingMarks` | `POST` | `/v1/posting/marks` | `scripts/methods/fbs-rfbs-marks/post-posting-marks.sh` | Получить маркировки экземпляров из отправления |
| `getProductExemplarStatusV5` | `POST` | `/v5/fbs/posting/product/exemplar/status` | `scripts/methods/fbs-rfbs-marks/get-product-exemplar-status-v5.sh` | Получить статус добавления экземпляров |
| `validateProductExemplarV5` | `POST` | `/v5/fbs/posting/product/exemplar/validate` | `scripts/methods/fbs-rfbs-marks/validate-product-exemplar-v5.sh` | Валидация кодов маркировки |
| `createOrGetProductExemplarV6` | `POST` | `/v6/fbs/posting/product/exemplar/create-or-get` | `scripts/methods/fbs-rfbs-marks/create-or-get-product-exemplar-v6.sh` | Получить данные созданных экземпляров |
| `setProductExemplarV6` | `POST` | `/v6/fbs/posting/product/exemplar/set` | `scripts/methods/fbs-rfbs-marks/set-product-exemplar-v6.sh` | Проверить и сохранить данные экземпляров |
