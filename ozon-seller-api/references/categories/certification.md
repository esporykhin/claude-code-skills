# Certification

- Category key: `certification`
- Methods in local catalog: `14`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getCertificateAccordanceTypesV1` | `GET` | `/v1/product/certificate/accordance-types` | `scripts/methods/certification/get-certificate-accordance-types-v1.sh` | Список типов соответствия требованиям (версия 1) |
| `bindCertificate` | `POST` | `/v1/product/certificate/bind` | `scripts/methods/certification/bind-certificate.sh` | Привязать сертификат к товару |
| `createCertificate` | `POST` | `/v1/product/certificate/create` | `scripts/methods/certification/create-certificate.sh` | Добавить сертификаты для товаров |
| `deleteCertificates` | `DELETE` | `/v1/product/certificate/delete` | `scripts/methods/certification/delete-certificates.sh` | Удалить сертификат |
| `getCertificateInfo` | `POST` | `/v1/product/certificate/info` | `scripts/methods/certification/get-certificate-info.sh` | Информация о сертификате |
| `getCertificateList` | `POST` | `/v1/product/certificate/list` | `scripts/methods/certification/get-certificate-list.sh` | Список сертификатов |
| `getProductStatusList` | `POST` | `/v1/product/certificate/product_status/list` | `scripts/methods/certification/get-product-status-list.sh` | Список возможных статусов товаров |
| `getCertificateProductsList` | `POST` | `/v1/product/certificate/products/list` | `scripts/methods/certification/get-certificate-products-list.sh` | Список товаров, привязанных к сертификату |
| `getRejectionReasons` | `POST` | `/v1/product/certificate/rejection_reasons/list` | `scripts/methods/certification/get-rejection-reasons.sh` | Возможные причины отклонения сертификата |
| `getCertificateStatuses` | `POST` | `/v1/product/certificate/status/list` | `scripts/methods/certification/get-certificate-statuses.sh` | Возможные статусы сертификатов |
| `getCertificateTypes` | `GET` | `/v1/product/certificate/types` | `scripts/methods/certification/get-certificate-types.sh` | Справочник типов документов |
| `unbindCertificate` | `POST` | `/v1/product/certificate/unbind` | `scripts/methods/certification/unbind-certificate.sh` | Отвязать товар от сертификата |
| `getCertificateAccordanceTypesV2` | `GET` | `/v2/product/certificate/accordance-types/list` | `scripts/methods/certification/get-certificate-accordance-types-v2.sh` | Список типов соответствия требованиям (версия 2) |
| `getProductCertificationListV2` | `POST` | `/v2/product/certification/list` | `scripts/methods/certification/get-product-certification-list-v2.sh` | Список сертифицируемых категорий |
