# Ozon Seller API skill — конфигурация

## Как получить Client-Id и Api-Key

1. Ozon Seller (https://seller.ozon.ru) → **Настройки → API**.
2. Вкладка **"API ключи"** → **"Сгенерировать ключ"**.
3. Выбери нужный scope (обычно Admin Read/Write) и назови ключ.
4. Скопируй **Client-Id** (виден всегда) и **Api-Key** (показывается один раз).

## Установка

### Вариант 1 — дать агенту

Передай в чате `OZON_CLIENT_ID` + `OZON_API_KEY`. Агент создаст `config/.env` автоматически.

### Вариант 2 — руками

```bash
cp config/.env.example config/.env
# отредактируй OZON_CLIENT_ID и OZON_API_KEY
chmod 600 config/.env
```

## Альтернативы

- `OZON_CLIENT_ID=... OZON_API_KEY=... ./scripts/ozon-request.sh ...` — env-переменные переопределяют `config/.env`.
- Файл `config/.env` в `.gitignore`, в git не попадёт.

## Проверка

```bash
./scripts/ozon-request.sh POST /v1/roles --empty
```

Должен вернуть JSON со списком ролей твоего ключа.
