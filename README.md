# Claude Code Skills

Коллекция скиллов для [Claude Code](https://claude.ai/code). Каждый скилл — самодостаточный модуль с API-справочником и готовыми bash-скриптами. Агент подгружает скилл по контексту и сразу работает с API без написания кода.

## Скиллы

| Скилл | Что делает | API |
|-------|-----------|-----|
| [ozon-seller-api](./ozon-seller-api/) | Полный каталог Ozon Seller API: 38 категорий, 409 bash-wrapper'ов, поиск методов и raw-вызовы | [Ozon Seller API](https://docs.ozon.ru/api/seller/) |
| [yandex-position-checker](./yandex-position-checker/) | Проверка позиций карточки организации в Яндекс Картах через публичный endpoint | [loocl.ru checker](https://loocl.ru/tools/position-checker) |

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

**Ключи:** `OZON_CLIENT_ID` + `OZON_API_KEY` в переменных окружения или `~/.claude/credentials.env`

---

### Yandex Position Checker

Скилл для проверки позиций карточки организации в Яндекс Картах через публичный endpoint `POST /api/tools/check-positions` — повторяет логику бесплатного чекера на [loocl.ru/tools/position-checker](https://loocl.ru/tools/position-checker).

- Разовые и пакетные проверки локальной выдачи по ключевым запросам
- Сравнение позиций при разных координатах и радиусах
- Поиск по `targetOrgId` или `targetOrgUrl`

**Конфигурация:** `YANDEX_POSITION_CHECKER_BASE_URL` (по умолчанию `https://loocl.ru`) в переменных окружения или `~/.claude/credentials.env`.

## Лицензия

MIT
