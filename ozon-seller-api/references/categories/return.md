# Return

- Category key: `return`
- Methods in local catalog: `8`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getGiveoutBarcode` | `POST` | `/v1/return/giveout/barcode` | `scripts/methods/return/get-giveout-barcode.sh` | Значение штрихкода для возвратных отгрузок |
| `resetGiveoutBarcode` | `POST` | `/v1/return/giveout/barcode-reset` | `scripts/methods/return/reset-giveout-barcode.sh` | Сгенерировать новый штрихкод |
| `getGiveoutPDF` | `GET` | `/v1/return/giveout/get-pdf` | `scripts/methods/return/get-giveout-pdf.sh` | Штрихкод для получения возвратной отгрузки в формате PDF |
| `getGiveoutPNG` | `GET` | `/v1/return/giveout/get-png` | `scripts/methods/return/get-giveout-png.sh` | Штрихкод для получения возвратной отгрузки в формате PNG |
| `getGiveoutInfo` | `POST` | `/v1/return/giveout/info` | `scripts/methods/return/get-giveout-info.sh` | Информация о возвратной отгрузке |
| `isGiveoutEnabled` | `POST` | `/v1/return/giveout/is-enabled` | `scripts/methods/return/is-giveout-enabled.sh` | Проверить возможность получения возвратных отгрузок по штрихкоду |
| `getGiveoutList` | `POST` | `/v1/return/giveout/list` | `scripts/methods/return/get-giveout-list.sh` | Список возвратных отгрузок |
| `getReturnsCompanyFbsInfo` | `POST` | `/v1/returns/company/fbs/info` | `scripts/methods/return/get-returns-company-fbs-info.sh` | Количество возвратов FBS |
