# Claude Code Skills

Коллекция скиллов для [Claude Code](https://claude.ai/code). Каждый скилл — самодостаточный модуль с API-справочником и готовыми bash-скриптами. Агент подгружает скилл по контексту и сразу работает с API без написания кода.

## Скиллы

| Скилл | Что делает | API |
|-------|-----------|-----|
| [ozon-seller-api](./ozon-seller-api/) | Полный каталог Ozon Seller API: 38 категорий, 409 bash-wrapper'ов, поиск методов и raw-вызовы | [Ozon Seller API](https://docs.ozon.ru/api/seller/) |
| [yandex-position-checker](./yandex-position-checker/) | Проверка позиций карточки организации в Яндекс Картах через публичный endpoint | [loocl.ru checker](https://loocl.ru/tools/position-checker) |
| [amocrm-api](./amocrm-api/) | Справочник amoCRM REST API: OAuth 2.0, сделки, контакты, компании, задачи, webhooks, custom fields | [amoCRM API](https://www.amocrm.ru/developers/content/crm_platform/api-reference) |
| [kaiten](./kaiten/) | Kaiten API: карточки (CRUD, move, comments), доски, колонки, пространства, пользователи, теги | [Kaiten API](https://developers.kaiten.ru) |
| [dokploy-api](./dokploy-api/) | Dokploy API: проекты, applications (CRUD, deploy, env), GitHub-источник, домены с Let's Encrypt | [Dokploy](https://docs.dokploy.com) |

## Установка

```bash
git clone https://github.com/esporykhin/claude-code-skills.git

# Скопировать нужный скилл
cp -r claude-code-skills/ozon-seller-api ~/.claude/skills/ozon-seller-api
cp -r claude-code-skills/yandex-position-checker ~/.claude/skills/yandex-position-checker
```

После этого Claude Code автоматически подхватит скилл по контексту разговора.

## Как устроен скилл

```
skill-name/
├── SKILL.md          — точка входа, индекс, навигация
├── scripts/          — bash-скрипты, общий раннер и method wrappers
├── references/       — детальные API-контракты (подгружаются по запросу)
└── tests/            — e2e-smoke и локальный mock server (опционально)
```

`SKILL.md` загружается в контекст целиком как индекс. Файлы из `references/` агент читает только по необходимости. Скрипты из `scripts/` агент вызывает напрямую. Такая структура не забивает контекст, но даёт быстрый доступ к любому методу API.

---

### Ozon Seller API

Полноценный скилл для Ozon Seller API, собранный вокруг bash-first workflow и нормальной навигации по методам.

**38 категорий, 409 wrapper-скриптов, e2e smoke-тесты.**

- Каталог методов по категориям: товары, цены, остатки, FBS, FBO, FBP, отчёты, финансы, возвраты, чат, уведомления, Ozon Логистика, склады и служебные API
- Поиск метода через `scripts/ozon-find-method.sh`
- Универсальный raw-вызов через `scripts/ozon-request.sh`
- Точечные wrapper-скрипты в `scripts/methods/<category>/`
- E2E-проверка bash-слоя через `tests/e2e.sh`

**Ключи:** `OZON_CLIENT_ID` + `OZON_API_KEY` в `config/.env` внутри скилла (см. `ozon-seller-api/config/README.md`) или env-переменные.

---

### Yandex Position Checker

Скилл для проверки позиций карточки организации в Яндекс Картах через публичный endpoint `POST /api/tools/check-positions` — повторяет логику бесплатного чекера на [loocl.ru/tools/position-checker](https://loocl.ru/tools/position-checker).

- Разовые и пакетные проверки локальной выдачи по ключевым запросам
- Сравнение позиций при разных координатах и радиусах
- Поиск по `targetOrgId` или `targetOrgUrl`

**Конфигурация:** по умолчанию работает без настройки (`https://loocl.ru`). Для переопределения — `config/.env` внутри скилла или env-переменные (см. `yandex-position-checker/config/README.md`).

---

### amoCRM API

Справочник по REST API amoCRM для интеграций — сделки, контакты, компании, задачи, webhooks, custom fields, воронки.

- OAuth 2.0 flow, time-to-live токенов, refresh token gotchas
- Все основные эндпоинты `/api/v4/*` с примерами curl
- Форматы `custom_fields_values`, `_embedded`, фильтры, пагинация
- Webhooks: подписка, события, формат входящих payload (form-urlencoded)
- Reference-файлы по сущностям подгружаются по запросу

**Конфигурация:** `access_token` выдаётся через OAuth 2.0 per-аккаунт. Base URL: `https://{subdomain}.amocrm.ru/api/v4/`.

---

### Kaiten

Скилл для [Kaiten API](https://developers.kaiten.ru) — управление карточками и досками через готовые bash-скрипты.

- Карточки: создать, обновить, переместить между колонками, архивировать, удалить
- Комментарии, участники, теги, чеклисты
- Навигация: пространства → доски → колонки/дорожки
- Пользователи и теги
- `kaiten-request.sh` для произвольных запросов к любому endpoint

**Ключи:** `KAITEN_DOMAIN` + `KAITEN_TOKEN` в `config/.env` внутри скилла (см. `kaiten/config/README.md`). Токен берётся в Kaiten → Профиль → API.

---

### Dokploy API

Скилл для управления self-hosted PaaS [Dokploy](https://dokploy.com) через bash-обёртки над tRPC API.

- Проекты, environments, applications (создание, деплой, остановка, удаление)
- Привязка к git: GitHub App (auto-deploy по push) или custom git с SSH-ключом
- Домены с Let's Encrypt-сертификатами
- Билд-настройки: Dockerfile / Nixpacks / buildpacks
- ENV-переменные через текстовый блок
- Универсальный `dokploy-request.sh` для любого tRPC-эндпоинта

**Ключи:** `DOKPLOY_URL` + `DOKPLOY_API_KEY` в `config/.env` (см. `dokploy-api/config/README.md`). Токен в Dokploy UI → Settings → API/CLI.

## Лицензия

MIT
