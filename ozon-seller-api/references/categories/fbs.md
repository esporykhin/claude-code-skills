# Fbs

- Category key: `fbs`
- Methods in local catalog: `37`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getCancelReasons` | `POST` | `/v1/posting/fbs/cancel-reason` | `scripts/methods/fbs/get-cancel-reasons.sh` | Причины отмены отправления |
| `getLabelBatch` | `POST` | `/v1/posting/fbs/package-label/get` | `scripts/methods/fbs/get-label-batch.sh` | Получить файл с этикетками |
| `verifyPickupCode` | `POST` | `/v1/posting/fbs/pick-up-code/verify` | `scripts/methods/fbs/verify-pickup-code.sh` | Проверить код курьера |
| `postPostingFbsProductTraceableAttribute` | `POST` | `/v1/posting/fbs/product/traceable/attribute` | `scripts/methods/fbs/post-posting-fbs-product-traceable-attribute.sh` | Получить список незаполненных атрибутов для прослеживаемых товаров`post |
| `getRestrictions` | `POST` | `/v1/posting/fbs/restrictions` | `scripts/methods/fbs/get-restrictions.sh` | Получить ограничения пункта приёма |
| `splitPosting` | `POST` | `/v1/posting/fbs/split` | `scripts/methods/fbs/split-posting.sh` | Разделить заказ на отправления без сборки |
| `getTimeslotChangeRestrictions` | `POST` | `/v1/posting/fbs/timeslot/change-restrictions` | `scripts/methods/fbs/get-timeslot-change-restrictions.sh` | Доступные даты для переноса доставки |
| `setTimeslot` | `POST` | `/v1/posting/fbs/timeslot/set` | `scripts/methods/fbs/set-timeslot.sh` | Перенести дату доставки |
| `postPostingFbsTraceableSplit` | `POST` | `/v1/posting/fbs/traceable/split` | `scripts/methods/fbs/post-posting-fbs-traceable-split.sh` | Разделить отправление с прослеживаемыми товарами |
| `getEtgb` | `POST` | `/v1/posting/global/etgb` | `scripts/methods/fbs/get-etgb.sh` | Таможенные декларации ETGB |
| `getUnpaidLegalProductList` | `POST` | `/v1/posting/unpaid-legal/product/list` | `scripts/methods/fbs/get-unpaid-legal-product-list.sh` | Список неоплаченных товаров, заказанных юридическими лицами |
| `checkActStatus` | `POST` | `/v2/posting/fbs/act/check-status` | `scripts/methods/fbs/check-act-status.sh` | Статус отгрузки и документов |
| `createAct` | `POST` | `/v2/posting/fbs/act/create` | `scripts/methods/fbs/create-act.sh` | Подтвердить отгрузку и создать документы |
| `getBarcode` | `POST` | `/v2/posting/fbs/act/get-barcode` | `scripts/methods/fbs/get-barcode.sh` | Штрихкод для отгрузки отправления |
| `getBarcodeText` | `POST` | `/v2/posting/fbs/act/get-barcode/text` | `scripts/methods/fbs/get-barcode-text.sh` | Значение штрихкода для отгрузки отправления |
| `getContainerLabels` | `POST` | `/v2/posting/fbs/act/get-container-labels` | `scripts/methods/fbs/get-container-labels.sh` | Этикетки для грузового места |
| `getAct` | `POST` | `/v2/posting/fbs/act/get-pdf` | `scripts/methods/fbs/get-act.sh` | Получить PDF c документами |
| `getActPostings` | `POST` | `/v2/posting/fbs/act/get-postings` | `scripts/methods/fbs/get-act-postings.sh` | Список отправлений в акте |
| `getActList` | `POST` | `/v2/posting/fbs/act/list` | `scripts/methods/fbs/get-act-list.sh` | Список актов по отгрузкам |
| `moveToArbitration` | `POST` | `/v2/posting/fbs/arbitration` | `scripts/methods/fbs/move-to-arbitration.sh` | Открыть спор по отправлению |
| `moveToAwaitingDelivery` | `POST` | `/v2/posting/fbs/awaiting-delivery` | `scripts/methods/fbs/move-to-awaiting-delivery.sh` | Передать отправление к отгрузке |
| `cancelPosting` | `POST` | `/v2/posting/fbs/cancel` | `scripts/methods/fbs/cancel-posting.sh` | Отменить отправление |
| `getCancelReasonsList` | `POST` | `/v2/posting/fbs/cancel-reason/list` | `scripts/methods/fbs/get-cancel-reasons-list.sh` | Причины отмены отправлений |
| `checkDigitalActStatus` | `POST` | `/v2/posting/fbs/digital/act/check-status` | `scripts/methods/fbs/check-digital-act-status.sh` | Статус формирования накладной |
| `getDigitalAct` | `POST` | `/v2/posting/fbs/digital/act/get-pdf` | `scripts/methods/fbs/get-digital-act.sh` | Получить лист отгрузки по перевозке |
| `getPostingByBarcode` | `POST` | `/v2/posting/fbs/get-by-barcode` | `scripts/methods/fbs/get-posting-by-barcode.sh` | Получить информацию об отправлении по штрихкоду |
| `packageLabel` | `POST` | `/v2/posting/fbs/package-label` | `scripts/methods/fbs/package-label.sh` | Напечатать этикетку |
| `createLabelBatchV2` | `POST` | `/v2/posting/fbs/package-label/create` | `scripts/methods/fbs/create-label-batch-v2.sh` | Создать задание на формирование этикеток |
| `cancelProducts` | `POST` | `/v2/posting/fbs/product/cancel` | `scripts/methods/fbs/cancel-products.sh` | Отменить отправку некоторых товаров в отправлении |
| `getProductCountriesList` | `POST` | `/v2/posting/fbs/product/country/list` | `scripts/methods/fbs/get-product-countries-list.sh` | Список доступных стран-изготовителей |
| `setProductCountry` | `POST` | `/v2/posting/fbs/product/country/set` | `scripts/methods/fbs/set-product-country.sh` | Добавить информацию о стране-изготовителе товара |
| `getPostingV3` | `POST` | `/v3/posting/fbs/get` | `scripts/methods/fbs/get-posting-v3.sh` | Получить информацию об отправлении по идентификатору |
| `getPostingListV3` | `POST` | `/v3/posting/fbs/list` | `scripts/methods/fbs/get-posting-list-v3.sh` | Список отправлений |
| `getUnfulfilledListV3` | `POST` | `/v3/posting/fbs/unfulfilled/list` | `scripts/methods/fbs/get-unfulfilled-list-v3.sh` | Список необработанных отправлений |
| `setMultiBoxQtyV3` | `POST` | `/v3/posting/multiboxqty/set` | `scripts/methods/fbs/set-multi-box-qty-v3.sh` | Указать количество коробок для многокоробочных отправлений |
| `shipPostingV4` | `POST` | `/v4/posting/fbs/ship` | `scripts/methods/fbs/ship-posting-v4.sh` | Собрать заказ (версия 4) |
| `shipPostingPackageV4` | `POST` | `/v4/posting/fbs/ship/package` | `scripts/methods/fbs/ship-posting-package-v4.sh` | Частичная сборка отправления (версия 4) |
