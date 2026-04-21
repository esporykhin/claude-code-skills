# Polygon

- Category key: `polygon`
- Methods in local catalog: `6`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `createDeliveryPolygon` | `POST` | `/v1/polygon/create` | `scripts/methods/polygon/create-delivery-polygon.sh` | Создайте полигон доставки |
| `deletePolygonDelete` | `DELETE` | `/v1/polygon/delete` | `scripts/methods/polygon/delete-polygon-delete.sh` | Удалить полигон из области доставки |
| `postPolygonList` | `POST` | `/v1/polygon/list` | `scripts/methods/polygon/post-polygon-list.sh` | Получить список установленных полигонов на метод доставки |
| `postPolygonTimeCoordinatesUpdate` | `POST` | `/v1/polygon/time/coordinates/update` | `scripts/methods/polygon/post-polygon-time-coordinates-update.sh` | Обновить координаты полигона доставки |
| `postPolygonTimeSet` | `POST` | `/v1/polygon/time/set` | `scripts/methods/polygon/post-polygon-time-set.sh` | Установить новое время доставки в полигоне |
| `postPolygonBind` | `POST` | `/v2/polygon/bind` | `scripts/methods/polygon/post-polygon-bind.sh` | Связать метод доставки с полигоном |
