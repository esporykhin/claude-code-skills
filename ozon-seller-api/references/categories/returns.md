# Returns

- Category key: `returns`
- Methods in local catalog: `4`

## How To Use

1. Найди нужный метод по таблице ниже.
2. Если payload неочевиден, сверяйся с source doc или официальной документацией Ozon.
3. Запускай wrapper из колонки `script`.
4. Если wrapper есть, но нужно проверить wording или соседние методы, открой source markdown только для этого куска.

## Methods

| method | http | path | script | note |
|---|---|---|---|---|
| `getList` | `POST` | `/v1/returns/list` | `scripts/methods/returns/get-list.sh` | Информация о возвратах FBO и FBS |
| `postReturnsSettingsUtilizationHistory` | `POST` | `/v1/returns/settings/utilization/history` | `scripts/methods/returns/post-returns-settings-utilization-history.sh` | Получить историю изменений автоутилизации |
| `postReturnsSettingsUtilizationInfo` | `POST` | `/v1/returns/settings/utilization/info` | `scripts/methods/returns/post-returns-settings-utilization-info.sh` | Получить настройки автоутилизации |
| `postReturnsSettingsUtilizationUpdate` | `POST` | `/v1/returns/settings/utilization/update` | `scripts/methods/returns/post-returns-settings-utilization-update.sh` | Обновить настройки автоутилизации |
