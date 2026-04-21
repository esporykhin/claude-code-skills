# Barcode

- Category key: `barcode`
- Methods in local catalog: `2`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `addBarcodes` | `POST` | `/v1/barcode/add` | `scripts/methods/barcode/add-barcodes.sh` | Привязать штрихкод к товару |
| `generateBarcodes` | `POST` | `/v1/barcode/generate` | `scripts/methods/barcode/generate-barcodes.sh` | Создать штрихкод для товара |
