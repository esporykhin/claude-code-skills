# Fbo Supply Request

- Category key: `fbo-supply-request`
- Methods in local catalog: `35`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `createCargoLabels` | `POST` | `/v1/cargoes-label/create` | `scripts/methods/fbo-supply-request/create-cargo-labels.sh` | Сгенерировать этикетки для грузомест |
| `getCargoesLabelFileFileGuid` | `GET` | `/v1/cargoes-label/file/{file_guid}` | `scripts/methods/fbo-supply-request/get-cargoes-label-file-file-guid.sh` | Получить PDF с этикетками грузовых мест |
| `getCargoLabels` | `GET` | `/v1/cargoes-label/get` | `scripts/methods/fbo-supply-request/get-cargo-labels.sh` | Получить идентификатор этикетки для грузомест |
| `postCargoes` | `POST` | `/v1/cargoes/` | `scripts/methods/fbo-supply-request/post-cargoes.sh` | Информация о статусе удаления грузоместа |
| `createCargoes` | `POST` | `/v1/cargoes/create` | `scripts/methods/fbo-supply-request/create-cargoes.sh` | Установка грузомест |
| `deleteCargoes` | `DELETE` | `/v1/cargoes/delete` | `scripts/methods/fbo-supply-request/delete-cargoes.sh` | Удалить грузоместо в заявке на поставку |
| `getCargoesGet` | `GET` | `/v1/cargoes/get` | `scripts/methods/fbo-supply-request/get-cargoes-get.sh` | Получить информацию о грузоместах |
| `getCargoRules` | `GET` | `/v1/cargoes/rules/get` | `scripts/methods/fbo-supply-request/get-cargo-rules.sh` | Чек-лист по установке грузомест FBO |
| `getClusterList` | `POST` | `/v1/cluster/list` | `scripts/methods/fbo-supply-request/get-cluster-list.sh` | Информация о кластерах и их складах |
| `createDraft` | `POST` | `/v1/draft/create` | `scripts/methods/fbo-supply-request/create-draft.sh` | Создать черновик заявки на поставку |
| `postDraftCrossdockCreate` | `POST` | `/v1/draft/crossdock/create` | `scripts/methods/fbo-supply-request/post-draft-crossdock-create.sh` | Создать черновик заявки на поставку кросс-докингом |
| `postDraftDirectCreate` | `POST` | `/v1/draft/direct/create` | `scripts/methods/fbo-supply-request/post-draft-direct-create.sh` | Создать черновик заявки на прямую поставку |
| `postDraftMultiClusterCreate` | `POST` | `/v1/draft/multi-cluster/create` | `scripts/methods/fbo-supply-request/post-draft-multi-cluster-create.sh` | Создать черновик заявки на поставку для нескольких кластеров |
| `getWarehouseAvailability` | `GET` | `/v1/supplier/available_warehouses` | `scripts/methods/fbo-supply-request/get-warehouse-availability.sh` | Загруженность складов Ozon |
| `getSupplyOrderBundle` | `POST` | `/v1/supply-order/bundle` | `scripts/methods/fbo-supply-request/get-supply-order-bundle.sh` | Состав поставки или заявки на поставку |
| `cancelSupplyOrder` | `POST` | `/v1/supply-order/cancel` | `scripts/methods/fbo-supply-request/cancel-supply-order.sh` | Отменить заявку на поставку |
| `getSupplyOrderCancelStatus` | `POST` | `/v1/supply-order/cancel/status` | `scripts/methods/fbo-supply-request/get-supply-order-cancel-status.sh` | Получить статус отмены заявки на поставку |
| `updateSupplyOrderContent` | `POST` | `/v1/supply-order/content/update` | `scripts/methods/fbo-supply-request/update-supply-order-content.sh` | Редактирование товарного состава |
| `getSupplyOrderContentUpdateStatus` | `POST` | `/v1/supply-order/content/update/status` | `scripts/methods/fbo-supply-request/get-supply-order-content-update-status.sh` | Информация о статусе редактирования товарного состава |
| `postSupplyOrderContentUpdateValidation` | `POST` | `/v1/supply-order/content/update/validation` | `scripts/methods/fbo-supply-request/post-supply-order-content-update-validation.sh` | Проверить новый товарный состав |
| `postSupplyOrderDetails` | `POST` | `/v1/supply-order/details` | `scripts/methods/fbo-supply-request/post-supply-order-details.sh` | Получить подробную информацию о заявке на поставку |
| `createSupplyOrderPass` | `POST` | `/v1/supply-order/pass/create` | `scripts/methods/fbo-supply-request/create-supply-order-pass.sh` | Указать данные о водителе и автомобиле |
| `getSupplyOrderPassStatus` | `POST` | `/v1/supply-order/pass/status` | `scripts/methods/fbo-supply-request/get-supply-order-pass-status.sh` | Статус ввода данных о водителе и автомобиле |
| `getSupplyOrderStatusCounter` | `POST` | `/v1/supply-order/status/counter` | `scripts/methods/fbo-supply-request/get-supply-order-status-counter.sh` | Количество заявок по статусам |
| `getSupplyOrderTimeslots` | `GET` | `/v1/supply-order/timeslot/get` | `scripts/methods/fbo-supply-request/get-supply-order-timeslots.sh` | Интервалы поставки |
| `getSupplyOrderTimeslotStatus` | `POST` | `/v1/supply-order/timeslot/status` | `scripts/methods/fbo-supply-request/get-supply-order-timeslot-status.sh` | Статус интервала поставки |
| `updateSupplyOrderTimeslot` | `POST` | `/v1/supply-order/timeslot/update` | `scripts/methods/fbo-supply-request/update-supply-order-timeslot.sh` | Обновить интервал поставки |
| `postCargoesCreateInfo` | `POST` | `/v2/cargoes/create/info` | `scripts/methods/fbo-supply-request/post-cargoes-create-info.sh` | Получить информацию по установке грузомест |
| `postClusterList` | `POST` | `/v2/cluster/list` | `scripts/methods/fbo-supply-request/post-cluster-list.sh` | Получить информацию о макролокальных кластерах |
| `postDraftCreateInfo` | `POST` | `/v2/draft/create/info` | `scripts/methods/fbo-supply-request/post-draft-create-info.sh` | Получить информацию о черновике заявки на поставку |
| `postDraftSupplyCreate` | `POST` | `/v2/draft/supply/create` | `scripts/methods/fbo-supply-request/post-draft-supply-create.sh` | Создать заявку на поставку по черновику |
| `postDraftSupplyCreateStatus` | `POST` | `/v2/draft/supply/create/status` | `scripts/methods/fbo-supply-request/post-draft-supply-create-status.sh` | Получить информацию о создании заявки на поставку |
| `postDraftTimeslotInfo` | `POST` | `/v2/draft/timeslot/info` | `scripts/methods/fbo-supply-request/post-draft-timeslot-info.sh` | Получить список доступных таймслотов |
| `getSupplyOrderGet` | `GET` | `/v3/supply-order/get` | `scripts/methods/fbo-supply-request/get-supply-order-get.sh` | Информация о заявке на поставку |
| `postSupplyOrderList` | `POST` | `/v3/supply-order/list` | `scripts/methods/fbo-supply-request/post-supply-order-list.sh` | Список заявок на поставку на склад Ozon |
