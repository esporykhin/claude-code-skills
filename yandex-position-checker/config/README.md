# Yandex Position Checker — конфигурация

Публичный чекер не требует токена — по умолчанию достаточно ничего не настраивать, дефолтный `https://loocl.ru` работает сразу. Конфиг нужен только для переопределения base URL или подключения Яндекс.Геокодера.

## Переменные

- `YANDEX_POSITION_CHECKER_BASE_URL` — base URL API (default `https://loocl.ru`).
- `YANDEX_GEOCODER_API_KEY` — ключ Яндекс.Геокодера для поиска по адресу в России. Получить бесплатно: https://developer.tech.yandex.ru

## Установка

### Вариант 1 — дать агенту

Передай нужные значения в чат, агент создаст `config/.env`.

### Вариант 2 — руками

```bash
cp config/.env.example config/.env
# отредактируй значения
chmod 600 config/.env
```

Файл `config/.env` в `.gitignore`.

Env-переменные переопределяют значения из `config/.env`.
