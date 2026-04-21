# Product

- Category key: `product`
- Methods in local catalog: `33`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getActionTimerStatus` | `POST` | `/v1/product/action/timer/status` | `scripts/methods/product/get-action-timer-status.sh` | Получить статус установленного таймера |
| `updateActionTimer` | `POST` | `/v1/product/action/timer/update` | `scripts/methods/product/update-action-timer.sh` | Обновление таймера актуальности минимальной цены |
| `archive` | `POST` | `/v1/product/archive` | `scripts/methods/product/archive.sh` | Перенести товар в архив |
| `updateAttributes` | `POST` | `/v1/product/attributes/update` | `scripts/methods/product/update-attributes.sh` | Обновить характеристики товара |
| `importBySku` | `POST` | `/v1/product/import-by-sku` | `scripts/methods/product/import-by-sku.sh` | Создать товар по SKU |
| `getImportInfo` | `POST` | `/v1/product/import/info` | `scripts/methods/product/get-import-info.sh` | Узнать статус добавления или обновления товара |
| `updatePrices` | `POST` | `/v1/product/import/prices` | `scripts/methods/product/update-prices.sh` | Обновить цену |
| `getProductDescription` | `POST` | `/v1/product/info/description` | `scripts/methods/product/get-product-description.sh` | Получить описание товара |
| `getDiscountedInfo` | `POST` | `/v1/product/info/discounted` | `scripts/methods/product/get-discounted-info.sh` | Узнать информацию об уценке и основном товаре по SKU уценённого товара |
| `getSubscription` | `POST` | `/v1/product/info/subscription` | `scripts/methods/product/get-subscription.sh` | Количество подписавшихся на товар пользователей |
| `postProductInfoWarehouseStocks` | `POST` | `/v1/product/info/warehouse/stocks` | `scripts/methods/product/post-product-info-warehouse-stocks.sh` | Получить информацию по остаткам на складе FBS и rFBS |
| `getProductsWithWrongVolume` | `POST` | `/v1/product/info/wrong-volume` | `scripts/methods/product/get-products-with-wrong-volume.sh` | Список товаров с некорректными ОВХ |
| `importPictures` | `POST` | `/v1/product/pictures/import` | `scripts/methods/product/import-pictures.sh` | Загрузить или обновить изображения товара |
| `postProductPlacementZoneInfo` | `POST` | `/v1/product/placement-zone/info` | `scripts/methods/product/post-product-placement-zone-info.sh` | Получить зоны размещения товаров по SKU перед поставкой |
| `getProductRating` | `POST` | `/v1/product/rating-by-sku` | `scripts/methods/product/get-product-rating.sh` | Получить контент-рейтинг товаров по SKU |
| `getRelatedSKU` | `GET` | `/v1/product/related-sku/get` | `scripts/methods/product/get-related-sku.sh` | Получить связанные SKU |
| `getProductStairwayDiscountByQuantityGet` | `GET` | `/v1/product/stairway-discount/by-quantity/get` | `scripts/methods/product/get-product-stairway-discount-by-quantity-get.sh` | Получить информацию о скидке от количества |
| `postProductStairwayDiscountByQuantitySet` | `POST` | `/v1/product/stairway-discount/by-quantity/set` | `scripts/methods/product/post-product-stairway-discount-by-quantity-set.sh` | Управлять скидкой от количества |
| `unarchive` | `POST` | `/v1/product/unarchive` | `scripts/methods/product/unarchive.sh` | Вернуть товар из архива |
| `updateDiscountedProductDiscount` | `POST` | `/v1/product/update/discount` | `scripts/methods/product/update-discounted-product-discount.sh` | Установить скидку на уценённый товар |
| `updateOfferID` | `POST` | `/v1/product/update/offer-id` | `scripts/methods/product/update-offer-id.sh` | Изменить артикулы товаров из системы продавца |
| `postProductVisibilitySet` | `POST` | `/v1/product/visibility/set` | `scripts/methods/product/post-product-visibility-set.sh` | Настроить видимость товара на витрине Ozon и Ozon Селект |
| `postProductInfoStocksByWarehouseFbs` | `POST` | `/v2/product/info/stocks-by-warehouse/fbs` | `scripts/methods/product/post-product-info-stocks-by-warehouse-fbs.sh` | Информация об остатках на складах продавца |
| `getPictures` | `POST` | `/v2/product/pictures/info` | `scripts/methods/product/get-pictures.sh` | Получить изображения товаров |
| `deleteProducts` | `DELETE` | `/v2/products/delete` | `scripts/methods/product/delete-products.sh` | Удалить товар без SKU из архива |
| `updateStocks` | `POST` | `/v2/products/stocks` | `scripts/methods/product/update-stocks.sh` | Обновить количество товаров на складах |
| `importProducts` | `POST` | `/v3/product/import` | `scripts/methods/product/import-products.sh` | Создать или обновить товар |
| `getProductInfoListV3` | `POST` | `/v3/product/info/list` | `scripts/methods/product/get-product-info-list-v3.sh` | Получить информацию о товарах по идентификаторам |
| `getListV3` | `POST` | `/v3/product/list` | `scripts/methods/product/get-list-v3.sh` | Список товаров |
| `getAttributes` | `POST` | `/v4/product/info/attributes` | `scripts/methods/product/get-attributes.sh` | Получить описание характеристик товара |
| `getUploadQuota` | `POST` | `/v4/product/info/limit` | `scripts/methods/product/get-upload-quota.sh` | Лимиты на ассортимент, создание и обновление товаров |
| `getStocks` | `POST` | `/v4/product/info/stocks` | `scripts/methods/product/get-stocks.sh` | Информация о количестве товаров |
| `getPrices` | `POST` | `/v5/product/info/prices` | `scripts/methods/product/get-prices.sh` | Получить информацию о цене товара |
