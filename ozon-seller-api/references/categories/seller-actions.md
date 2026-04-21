# Seller Actions

- Category key: `seller-actions`
- Methods in local catalog: `20`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `postSellerActionsArchive` | `POST` | `/v1/seller-actions/archive` | `scripts/methods/seller-actions/post-seller-actions-archive.sh` | Перенести акцию в архив |
| `postSellerActionsChangeActivity` | `POST` | `/v1/seller-actions/change-activity` | `scripts/methods/seller-actions/post-seller-actions-change-activity.sh` | Включить или выключить акцию |
| `postSellerActionsCreateDiscount` | `POST` | `/v1/seller-actions/create/discount` | `scripts/methods/seller-actions/post-seller-actions-create-discount.sh` | Создать акцию с механикой «Скидка» |
| `postSellerActionsCreateDiscountWithCondition` | `POST` | `/v1/seller-actions/create/discount-with-condition` | `scripts/methods/seller-actions/post-seller-actions-create-discount-with-condition.sh` | Создать акцию с механикой «Скидка от суммы заказа» |
| `postSellerActionsCreateInstallment` | `POST` | `/v1/seller-actions/create/installment` | `scripts/methods/seller-actions/post-seller-actions-create-installment.sh` | Создать акцию с механикой «Беспроцентная рассрочка» |
| `postSellerActionsCreateMultiLevelDiscount` | `POST` | `/v1/seller-actions/create/multi-level-discount` | `scripts/methods/seller-actions/post-seller-actions-create-multi-level-discount.sh` | Создать акцию с механикой «Многоуровневая скидка от суммы» |
| `postSellerActionsCreateOzonCardDiscount` | `POST` | `/v1/seller-actions/create/ozon-card-discount` | `scripts/methods/seller-actions/post-seller-actions-create-ozon-card-discount.sh` | Создать акцию с механикой «Повышенная скидка с картой Ozon Банка» |
| `postSellerActionsCreateVoucher` | `POST` | `/v1/seller-actions/create/voucher` | `scripts/methods/seller-actions/post-seller-actions-create-voucher.sh` | Создать акцию с механикой «Скидка по промокоду» |
| `postSellerActionsList` | `POST` | `/v1/seller-actions/list` | `scripts/methods/seller-actions/post-seller-actions-list.sh` | Получить список акций |
| `postSellerActionsProductsAdd` | `POST` | `/v1/seller-actions/products/add` | `scripts/methods/seller-actions/post-seller-actions-products-add.sh` | Добавить товары в акцию |
| `postSellerActionsProductsCandidates` | `POST` | `/v1/seller-actions/products/candidates` | `scripts/methods/seller-actions/post-seller-actions-products-candidates.sh` | Получить список доступных для акции товаров |
| `deleteSellerActionsProductsDelete` | `DELETE` | `/v1/seller-actions/products/delete` | `scripts/methods/seller-actions/delete-seller-actions-products-delete.sh` | Удалить товары из акции |
| `postSellerActionsProductsList` | `POST` | `/v1/seller-actions/products/list` | `scripts/methods/seller-actions/post-seller-actions-products-list.sh` | Получить список участвующих в акции товаров |
| `postSellerActionsUpdateDiscount` | `POST` | `/v1/seller-actions/update/discount` | `scripts/methods/seller-actions/post-seller-actions-update-discount.sh` | Обновить акцию с механикой «Скидка» |
| `postSellerActionsUpdateDiscountWithCondition` | `POST` | `/v1/seller-actions/update/discount-with-condition` | `scripts/methods/seller-actions/post-seller-actions-update-discount-with-condition.sh` | Обновить акцию с механикой «Скидка от суммы заказа» |
| `postSellerActionsUpdateInstallment` | `POST` | `/v1/seller-actions/update/installment` | `scripts/methods/seller-actions/post-seller-actions-update-installment.sh` | Обновить акцию с механикой «Беспроцентная рассрочка» |
| `postSellerActionsUpdateMultiLevelDiscount` | `POST` | `/v1/seller-actions/update/multi-level-discount` | `scripts/methods/seller-actions/post-seller-actions-update-multi-level-discount.sh` | Обновить акцию с механикой «Беспроцентная рассрочка» |
| `postSellerActionsUpdateOzonCardDiscount` | `POST` | `/v1/seller-actions/update/ozon-card-discount` | `scripts/methods/seller-actions/post-seller-actions-update-ozon-card-discount.sh` | Обновить акцию с механикой «Повышенная скидка с картой Ozon Банка» |
| `postSellerActionsUpdateVoucher` | `POST` | `/v1/seller-actions/update/voucher` | `scripts/methods/seller-actions/post-seller-actions-update-voucher.sh` | Обновить акцию с механикой «Скидка по промокоду» |
| `getSellerActionsVoucherGet` | `GET` | `/v1/seller-actions/voucher/get` | `scripts/methods/seller-actions/get-seller-actions-voucher-get.sh` | Получить файл с промокодами в формате CSV |
