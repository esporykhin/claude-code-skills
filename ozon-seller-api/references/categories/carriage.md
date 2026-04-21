# Carriage

- Category key: `carriage`
- Methods in local catalog: `16`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postAssemblyCarriagePostingList` | `POST` | `/v1/assembly/carriage/posting/list` | `scripts/methods/carriage/post-assembly-carriage-posting-list.sh` | Получить список отправлений в отгрузке |
| `postAssemblyCarriageProductList` | `POST` | `/v1/assembly/carriage/product/list` | `scripts/methods/carriage/post-assembly-carriage-product-list.sh` | Получить список товаров в отгрузке |
| `postAssemblyFbsPostingList` | `POST` | `/v1/assembly/fbs/posting/list` | `scripts/methods/carriage/post-assembly-fbs-posting-list.sh` | Получить список отправлений |
| `postAssemblyFbsProductList` | `POST` | `/v1/assembly/fbs/product/list` | `scripts/methods/carriage/post-assembly-fbs-product-list.sh` | Получить список товаров в отправлениях |
| `postCarriageActDiscrepancyPdf` | `POST` | `/v1/carriage/act-discrepancy/pdf` | `scripts/methods/carriage/post-carriage-act-discrepancy-pdf.sh` | Получить акт о расхождениях по отгрузке FBS |
| `approveCarriage` | `POST` | `/v1/carriage/approve` | `scripts/methods/carriage/approve-carriage.sh` | Подтверждение отгрузки |
| `cancelCarriage` | `POST` | `/v1/carriage/cancel` | `scripts/methods/carriage/cancel-carriage.sh` | Удаление отгрузки |
| `createCarriage` | `POST` | `/v1/carriage/create` | `scripts/methods/carriage/create-carriage.sh` | Создание отгрузки |
| `postCarriageEttnStatus` | `POST` | `/v1/carriage/ettn/status` | `scripts/methods/carriage/post-carriage-ettn-status.sh` | Получить статус проверки электронной ТТН на прослеживаемой перевозке FBS |
| `getCarriage` | `GET` | `/v1/carriage/get` | `scripts/methods/carriage/get-carriage.sh` | Информация о перевозке |
| `createCarriagePass` | `POST` | `/v1/carriage/pass/create` | `scripts/methods/carriage/create-carriage-pass.sh` | Создать пропуск |
| `deleteCarriagePass` | `DELETE` | `/v1/carriage/pass/delete` | `scripts/methods/carriage/delete-carriage-pass.sh` | Удалить пропуск |
| `updateCarriagePass` | `POST` | `/v1/carriage/pass/update` | `scripts/methods/carriage/update-carriage-pass.sh` | Обновить пропуск |
| `setPostings` | `POST` | `/v1/carriage/set-postings` | `scripts/methods/carriage/set-postings.sh` | Изменение состава отгрузки |
| `getCarriageAvailableList` | `POST` | `/v1/posting/carriage-available/list` | `scripts/methods/carriage/get-carriage-available-list.sh` | Список доступных перевозок |
| `postCarriageDeliveryList` | `POST` | `/v2/carriage/delivery/list` | `scripts/methods/carriage/post-carriage-delivery-list.sh` | Список методов доставки и отгрузок |
