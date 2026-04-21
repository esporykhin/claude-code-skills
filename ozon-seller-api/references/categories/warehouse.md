# Warehouse

- Category key: `warehouse`
- Methods in local catalog: `35`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getDeliveryMethodReturnSettingsGet` | `GET` | `/v1/delivery-method/return/settings/get` | `scripts/methods/warehouse/get-delivery-method-return-settings-get.sh` | Получить информацию по возвратным настройкам rFBS и rFBS Express |
| `postWarehouseArchive` | `POST` | `/v1/warehouse/archive` | `scripts/methods/warehouse/post-warehouse-archive.sh` | Перенести склад в архив |
| `postWarehouseErfbsAggregatorCreate` | `POST` | `/v1/warehouse/erfbs/aggregator/create` | `scripts/methods/warehouse/post-warehouse-erfbs-aggregator-create.sh` | Создать склад с методом доставки «Партнёры Ozon» |
| `postWarehouseErfbsAggregatorDeliveryMethodUpdate` | `POST` | `/v1/warehouse/erfbs/aggregator/delivery-method/update` | `scripts/methods/warehouse/post-warehouse-erfbs-aggregator-delivery-method-update.sh` | Обновить метод доставки «Партнёры Ozon» |
| `postWarehouseErfbsNonIntegratedCreate` | `POST` | `/v1/warehouse/erfbs/non-integrated/create` | `scripts/methods/warehouse/post-warehouse-erfbs-non-integrated-create.sh` | Создать склад с методом доставки «Вы или сторонняя служба» |
| `postWarehouseErfbsNonIntegratedDeliveryMethodUpdate` | `POST` | `/v1/warehouse/erfbs/non-integrated/delivery-method/update` | `scripts/methods/warehouse/post-warehouse-erfbs-non-integrated-delivery-method-update.sh` | Обновить метод доставки «Вы или сторонняя служба» |
| `postWarehouseErfbsUpdate` | `POST` | `/v1/warehouse/erfbs/update` | `scripts/methods/warehouse/post-warehouse-erfbs-update.sh` | Обновить склад |
| `getWarehouseFboList` | `POST` | `/v1/warehouse/fbo/list` | `scripts/methods/warehouse/get-warehouse-fbo-list.sh` | Поиск точек для отгрузки поставки |
| `postWarehouseFboSellerList` | `POST` | `/v1/warehouse/fbo/seller/list` | `scripts/methods/warehouse/post-warehouse-fbo-seller-list.sh` | Получить список складов продавца |
| `postWarehouseFbsCreate` | `POST` | `/v1/warehouse/fbs/create` | `scripts/methods/warehouse/post-warehouse-fbs-create.sh` | Создать склад |
| `postWarehouseFbsCreateDropOffList` | `POST` | `/v1/warehouse/fbs/create/drop-off/list` | `scripts/methods/warehouse/post-warehouse-fbs-create-drop-off-list.sh` | Получить список drop-off пунктов для создания склада |
| `postWarehouseFbsCreateDropOffTimeslotList` | `POST` | `/v1/warehouse/fbs/create/drop-off/timeslot/list` | `scripts/methods/warehouse/post-warehouse-fbs-create-drop-off-timeslot-list.sh` | Получить список таймслотов для создания склада с отгрузкой drop-off |
| `postWarehouseFbsCreatePickUpTimeslotList` | `POST` | `/v1/warehouse/fbs/create/pick-up/timeslot/list` | `scripts/methods/warehouse/post-warehouse-fbs-create-pick-up-timeslot-list.sh` | Получить список таймслотов для создания склада с отгрузкой pick-up |
| `postWarehouseFbsCreateReturnPointList` | `POST` | `/v1/warehouse/fbs/create/return-point/list` | `scripts/methods/warehouse/post-warehouse-fbs-create-return-point-list.sh` | Получить список пунктов возврата для создания склада |
| `postWarehouseFbsFirstMileUpdate` | `POST` | `/v1/warehouse/fbs/first-mile/update` | `scripts/methods/warehouse/post-warehouse-fbs-first-mile-update.sh` | Обновить первую милю |
| `postWarehouseFbsPickupCourierCancel` | `POST` | `/v1/warehouse/fbs/pickup/courier/cancel` | `scripts/methods/warehouse/post-warehouse-fbs-pickup-courier-cancel.sh` | Отменить вызов курьера на забор отгрузки pick-up |
| `postWarehouseFbsPickupCourierCreate` | `POST` | `/v1/warehouse/fbs/pickup/courier/create` | `scripts/methods/warehouse/post-warehouse-fbs-pickup-courier-create.sh` | Создать вызов курьера на забор отгрузки pick-up |
| `postWarehouseFbsPickupHistoryList` | `POST` | `/v1/warehouse/fbs/pickup/history/list` | `scripts/methods/warehouse/post-warehouse-fbs-pickup-history-list.sh` | Получить историю отгрузок курьерам |
| `postWarehouseFbsPickupPlanningList` | `POST` | `/v1/warehouse/fbs/pickup/planning/list` | `scripts/methods/warehouse/post-warehouse-fbs-pickup-planning-list.sh` | Получить список складов для планирования отгрузок курьеру |
| `postWarehouseFbsReturnMileCheck` | `POST` | `/v1/warehouse/fbs/return-mile/check` | `scripts/methods/warehouse/post-warehouse-fbs-return-mile-check.sh` | Проверить необходимость установки возвратной мили на склад |
| `postWarehouseFbsReturnMileInfo` | `POST` | `/v1/warehouse/fbs/return-mile/info` | `scripts/methods/warehouse/post-warehouse-fbs-return-mile-info.sh` | Получить информацию о возвратной миле |
| `postWarehouseFbsUpdate` | `POST` | `/v1/warehouse/fbs/update` | `scripts/methods/warehouse/post-warehouse-fbs-update.sh` | Обновить склад |
| `postWarehouseFbsUpdateDropOffList` | `POST` | `/v1/warehouse/fbs/update/drop-off/list` | `scripts/methods/warehouse/post-warehouse-fbs-update-drop-off-list.sh` | Получить список drop-off пунктов для изменения информации склада |
| `postWarehouseFbsUpdateDropOffTimeslotList` | `POST` | `/v1/warehouse/fbs/update/drop-off/timeslot/list` | `scripts/methods/warehouse/post-warehouse-fbs-update-drop-off-timeslot-list.sh` | Получить список таймслотов для обновления склада с отгрузкой drop-off |
| `postWarehouseFbsUpdatePickUpTimeslotList` | `POST` | `/v1/warehouse/fbs/update/pick-up/timeslot/list` | `scripts/methods/warehouse/post-warehouse-fbs-update-pick-up-timeslot-list.sh` | Получить список таймслотов для обновления склада с отгрузкой pick-up |
| `postWarehouseFbsUpdateReturnPointList` | `POST` | `/v1/warehouse/fbs/update/return-point/list` | `scripts/methods/warehouse/post-warehouse-fbs-update-return-point-list.sh` | Получить список пунктов возврата для обновления склада |
| `getWarehouseInvalidProductsGet` | `GET` | `/v1/warehouse/invalid-products/get` | `scripts/methods/warehouse/get-warehouse-invalid-products-get.sh` | Получить список товаров с ограничениями по доставке |
| `postWarehouseOperationStatus` | `POST` | `/v1/warehouse/operation/status` | `scripts/methods/warehouse/post-warehouse-operation-status.sh` | Получить статус операции |
| `postWarehouseOzonList` | `POST` | `/v1/warehouse/ozon/list` | `scripts/methods/warehouse/post-warehouse-ozon-list.sh` | Получить список складов Ozon |
| `postWarehouseRfbsPause` | `POST` | `/v1/warehouse/rfbs/pause` | `scripts/methods/warehouse/post-warehouse-rfbs-pause.sh` | Поставить rFBS-склад на паузу |
| `postWarehouseRfbsUnpause` | `POST` | `/v1/warehouse/rfbs/unpause` | `scripts/methods/warehouse/post-warehouse-rfbs-unpause.sh` | Снять rFBS-склад с паузы |
| `postWarehouseUnarchive` | `POST` | `/v1/warehouse/unarchive` | `scripts/methods/warehouse/post-warehouse-unarchive.sh` | Перенести склад из архива |
| `postWarehouseWarehousesWithInvalidProducts` | `POST` | `/v1/warehouse/warehouses-with-invalid-products` | `scripts/methods/warehouse/post-warehouse-warehouses-with-invalid-products.sh` | Получить список складов с ограниченными для доставки товарами |
| `postDeliveryMethodList` | `POST` | `/v2/delivery-method/list` | `scripts/methods/warehouse/post-delivery-method-list.sh` | Список методов доставки realFBS-склада |
| `postWarehouseList` | `POST` | `/v2/warehouse/list` | `scripts/methods/warehouse/post-warehouse-list.sh` | Список складов |
