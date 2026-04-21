# Fbp

- Category key: `fbp`
- Methods in local catalog: `45`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postFbpActFromCreate` | `POST` | `/v1/fbp/act-from/create` | `scripts/methods/fbp/post-fbp-act-from-create.sh` | Сгенерировать акт приёмки |
| `getFbpActFromGet` | `GET` | `/v1/fbp/act-from/get` | `scripts/methods/fbp/get-fbp-act-from-get.sh` | Получить статус генерации акта приёмки |
| `postFbpActToCreate` | `POST` | `/v1/fbp/act-to/create` | `scripts/methods/fbp/post-fbp-act-to-create.sh` | Сгенерировать транспортную накладную |
| `getFbpActToGet` | `GET` | `/v1/fbp/act-to/get` | `scripts/methods/fbp/get-fbp-act-to-get.sh` | Получить статус генерации транспортной накладной |
| `getFbpArchiveGet` | `GET` | `/v1/fbp/archive/get` | `scripts/methods/fbp/get-fbp-archive-get.sh` | Получить информацию о завершённой поставке |
| `postFbpArchiveList` | `POST` | `/v1/fbp/archive/list` | `scripts/methods/fbp/post-fbp-archive-list.sh` | Получить список завершённых поставок |
| `postFbpDraftDirectCreate` | `POST` | `/v1/fbp/draft/direct/create` | `scripts/methods/fbp/post-fbp-draft-direct-create.sh` | Создать черновик заявки на поставку без указания способа доставки |
| `deleteFbpDraftDirectDelete` | `DELETE` | `/v1/fbp/draft/direct/delete` | `scripts/methods/fbp/delete-fbp-draft-direct-delete.sh` | Удалить черновик заявки на поставку |
| `postFbpDraftDirectProductValidate` | `POST` | `/v1/fbp/draft/direct/product/validate` | `scripts/methods/fbp/post-fbp-draft-direct-product-validate.sh` | Проверить список товаров для склада партнёра |
| `postFbpDraftDirectRegistrate` | `POST` | `/v1/fbp/draft/direct/registrate` | `scripts/methods/fbp/post-fbp-draft-direct-registrate.sh` | Перевести черновик в действующую поставку |
| `postFbpDraftDirectSellerDlvCreate` | `POST` | `/v1/fbp/draft/direct/seller-dlv/create` | `scripts/methods/fbp/post-fbp-draft-direct-seller-dlv-create.sh` | Создать черновик с доставкой силами продавца |
| `postFbpDraftDirectSellerDlvEdit` | `POST` | `/v1/fbp/draft/direct/seller-dlv/edit` | `scripts/methods/fbp/post-fbp-draft-direct-seller-dlv-edit.sh` | Обновить информацию о доставке силами продавца в черновике |
| `postFbpDraftDirectTimeslotEdit` | `POST` | `/v1/fbp/draft/direct/timeslot/edit` | `scripts/methods/fbp/post-fbp-draft-direct-timeslot-edit.sh` | Отредактировать таймслот в черновике |
| `getFbpDraftDirectTimeslotGet` | `GET` | `/v1/fbp/draft/direct/timeslot/get` | `scripts/methods/fbp/get-fbp-draft-direct-timeslot-get.sh` | Получить список таймслотов для прямой поставки |
| `postFbpDraftDirectTplDlvCreate` | `POST` | `/v1/fbp/draft/direct/tpl-dlv/create` | `scripts/methods/fbp/post-fbp-draft-direct-tpl-dlv-create.sh` | Создать черновик заявки на доставку сторонней транспортной компанией |
| `postFbpDraftDirectTplDlvEdit` | `POST` | `/v1/fbp/draft/direct/tpl-dlv/edit` | `scripts/methods/fbp/post-fbp-draft-direct-tpl-dlv-edit.sh` | Редактировать черновик поставки со способом доставки сторонней транспортной компанией |
| `postFbpDraftDropOffCreate` | `POST` | `/v1/fbp/draft/drop-off/create` | `scripts/methods/fbp/post-fbp-draft-drop-off-create.sh` | Создать черновик для доставки в drop-off пункт |
| `deleteFbpDraftDropOffDelete` | `DELETE` | `/v1/fbp/draft/drop-off/delete` | `scripts/methods/fbp/delete-fbp-draft-drop-off-delete.sh` | Удалить черновик для доставки в drop-off пункт |
| `postFbpDraftDropOffDlvEdit` | `POST` | `/v1/fbp/draft/drop-off/dlv/edit` | `scripts/methods/fbp/post-fbp-draft-drop-off-dlv-edit.sh` | Отредактировать детали доставки для drop-off черновика |
| `postFbpDraftDropOffPointList` | `POST` | `/v1/fbp/draft/drop-off/point/list` | `scripts/methods/fbp/post-fbp-draft-drop-off-point-list.sh` | Получить список drop-off пунктов в провинции |
| `postFbpDraftDropOffPointTimetable` | `POST` | `/v1/fbp/draft/drop-off/point/timetable` | `scripts/methods/fbp/post-fbp-draft-drop-off-point-timetable.sh` | Получить расписание работы drop-off пункта |
| `postFbpDraftDropOffProductValidate` | `POST` | `/v1/fbp/draft/drop-off/product/validate` | `scripts/methods/fbp/post-fbp-draft-drop-off-product-validate.sh` | Получить расписание работы drop-off пункта |
| `postFbpDraftDropOffProvinceList` | `POST` | `/v1/fbp/draft/drop-off/province/list` | `scripts/methods/fbp/post-fbp-draft-drop-off-province-list.sh` | Получить список провинций |
| `postFbpDraftDropOffRegistrate` | `POST` | `/v1/fbp/draft/drop-off/registrate` | `scripts/methods/fbp/post-fbp-draft-drop-off-registrate.sh` | Перевести черновик в действующую поставку |
| `getFbpDraftGet` | `GET` | `/v1/fbp/draft/get` | `scripts/methods/fbp/get-fbp-draft-get.sh` | Получить информацию о черновике поставки |
| `postFbpDraftList` | `POST` | `/v1/fbp/draft/list` | `scripts/methods/fbp/post-fbp-draft-list.sh` | Список черновиков поставки |
| `postFbpDraftPickUpCreate` | `POST` | `/v1/fbp/draft/pick-up/create` | `scripts/methods/fbp/post-fbp-draft-pick-up-create.sh` | Создать черновик заявки на pick-up поставку |
| `deleteFbpDraftPickUpDelete` | `DELETE` | `/v1/fbp/draft/pick-up/delete` | `scripts/methods/fbp/delete-fbp-draft-pick-up-delete.sh` | Отменить черновик заявки на pick-up поставку |
| `postFbpDraftPickUpDlvEdit` | `POST` | `/v1/fbp/draft/pick-up/dlv/edit` | `scripts/methods/fbp/post-fbp-draft-pick-up-dlv-edit.sh` | Изменить черновик заявки на pick-up поставку |
| `postFbpDraftPickUpProductValidate` | `POST` | `/v1/fbp/draft/pick-up/product/validate` | `scripts/methods/fbp/post-fbp-draft-pick-up-product-validate.sh` | Провалидировать список товаров для pick-up поставки |
| `postFbpDraftPickUpRegistrate` | `POST` | `/v1/fbp/draft/pick-up/registrate` | `scripts/methods/fbp/post-fbp-draft-pick-up-registrate.sh` | Перевести черновик в действующую поставку |
| `postFbpLabelCreate` | `POST` | `/v1/fbp/label/create` | `scripts/methods/fbp/post-fbp-label-create.sh` | Cоздать задание на генерацию этикеток |
| `getFbpLabelGet` | `GET` | `/v1/fbp/label/get` | `scripts/methods/fbp/get-fbp-label-get.sh` | Получить статус задания на генерацию этикеток |
| `postFbpOrderDirectCancel` | `POST` | `/v1/fbp/order/direct/cancel` | `scripts/methods/fbp/post-fbp-order-direct-cancel.sh` | Отменить поставку |
| `postFbpOrderDirectSellerDlvEdit` | `POST` | `/v1/fbp/order/direct/seller-dlv/edit` | `scripts/methods/fbp/post-fbp-order-direct-seller-dlv-edit.sh` | Обновить информацию о доставке силами продавца |
| `postFbpOrderDirectTimeslotEdit` | `POST` | `/v1/fbp/order/direct/timeslot/edit` | `scripts/methods/fbp/post-fbp-order-direct-timeslot-edit.sh` | Отредактировать таймслот в заявке на поставку |
| `postFbpOrderDirectTimeslotList` | `POST` | `/v1/fbp/order/direct/timeslot/list` | `scripts/methods/fbp/post-fbp-order-direct-timeslot-list.sh` | Получить список таймслотов для поставки |
| `postFbpOrderDropOffCancel` | `POST` | `/v1/fbp/order/drop-off/cancel` | `scripts/methods/fbp/post-fbp-order-drop-off-cancel.sh` | Отменить поставку drop-off |
| `postFbpOrderDropOffDlvEdit` | `POST` | `/v1/fbp/order/drop-off/dlv/edit` | `scripts/methods/fbp/post-fbp-order-drop-off-dlv-edit.sh` | Отредактировать информацию о поставке на drop-off пункт |
| `postFbpOrderDropOffTimetable` | `POST` | `/v1/fbp/order/drop-off/timetable` | `scripts/methods/fbp/post-fbp-order-drop-off-timetable.sh` | Получить график работы drop-off пункта |
| `getFbpOrderGet` | `GET` | `/v1/fbp/order/get` | `scripts/methods/fbp/get-fbp-order-get.sh` | Получить информацию о конкретной поставке |
| `postFbpOrderList` | `POST` | `/v1/fbp/order/list` | `scripts/methods/fbp/post-fbp-order-list.sh` | Получить список поставок |
| `postFbpOrderPickUpCancel` | `POST` | `/v1/fbp/order/pick-up/cancel` | `scripts/methods/fbp/post-fbp-order-pick-up-cancel.sh` | Отменить pick-up поставку |
| `postFbpOrderPickUpDlvEdit` | `POST` | `/v1/fbp/order/pick-up/dlv/edit` | `scripts/methods/fbp/post-fbp-order-pick-up-dlv-edit.sh` | Изменить данные о точке забора |
| `postFbpWarehouseList` | `POST` | `/v1/fbp/warehouse/list` | `scripts/methods/fbp/post-fbp-warehouse-list.sh` | Получить список партнёрских складов |
