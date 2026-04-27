# Dokploy API — common reference

## Транспорт

- Базовый URL: `${DOKPLOY_URL}/api/<resource>.<action>`
- Метод: GET для read, POST для всех write (даже update/delete).
- Заголовок: `x-api-key: <DOKPLOY_API_KEY>`. `Content-Type: application/json`.
- Все POST принимают JSON-body. Если тело пустое — отправляй `{}`.

## Формат ответа

- Успех: 200 + JSON (объект, массив или `true`).
- Ошибки tRPC:
  ```json
  {
    "message": "Input validation failed",
    "code": "BAD_REQUEST",
    "data": { "code": "BAD_REQUEST", "httpStatus": 400, "zodError": {...} }
  }
  ```
- 404 на несуществующий эндпоинт: `{"code":"NOT_FOUND"}`.
- 401: невалидный/просроченный токен.

## Открытие неизвестных эндпоинтов

Полного OpenAPI Dokploy не отдаёт (`/swagger` редиректит на `/`, `/openapi.json` пуст). Для поиска нужного эндпоинта:

1. Угадай по паттерну `<resource>.<action>` — `all`, `one`, `create`, `update`, `delete`, `start`, `stop`, `deploy`.
2. Проверь через `dokploy-request.sh GET <procedure>` — `NOT_FOUND` = такого нет.
3. Если знаешь похожий: посмотри в коде `Dokploy/dokploy` на GitHub в `apps/dokploy/server/api/routers/`.

## Идентификаторы

| Префикс/тип | Сущность |
|-------------|---------|
| `projectId` | проект |
| `environmentId` | окружение (production/staging/...) |
| `applicationId` | приложение |
| `composeId` | docker-compose стек |
| `serverId` | remote-нод |
| `domainId` | домен |
| `gitProviderId` / `githubId` | git-провайдер / id GitHub App записи |
| `sshKeyId` | SSH-ключ в Dokploy |
| `appName` | имя контейнера/swarm-сервиса (с авто-суффиксом) |

`applicationId` — внутренний UUID-like, `appName` — slug с суффиксом для namespace в Docker.

## Полезные эндпоинты не в methods/

| Procedure | Описание |
|-----------|---------|
| `compose.create`/`compose.deploy`/`compose.one` | docker-compose стеки |
| `postgres.create`/`postgres.deploy` | управляемая БД |
| `redis.create` | Redis |
| `deployment.allByApplication` | история деплоев (если включена) |
| `notification.*` | webhooks/Slack/email уведомления |
| `traefik.update` | глобальный traefik.yml |
| `cluster.*` | управление swarm |
| `auth.*` | пользователи, токены |

Зови их через `dokploy-request.sh`.

## Логи и debug

Логи деплоя у Dokploy физически на том сервере, где деплоилось приложение, по пути:

```
/etc/dokploy/logs/<appName>/<appName>-<YYYY-MM-DD:HH:MM:SS>.log
```

Файлы Traefik dynamic config:

```
/etc/dokploy/traefik/dynamic/<appName>.yml
/etc/dokploy/traefik/dynamic/middlewares.yml
/etc/dokploy/traefik/dynamic/acme.json
```

Доступ — по SSH к нужному серверу.

## Ограничения и особенности

- Каждый POST на write возвращает либо обновлённый объект, либо просто `true`. Для гарантии — после write делай `application.one` и читай актуальное состояние.
- При смене `sourceType` сохраняй `watchPaths:[]` (даже пустой). Без него Zod валидатор отвалится.
- `application.update` пустым телом возвращает 500 «No values to set» — всегда передавай хотя бы одно поле.
- Билд идёт асинхронно. Опрашивай `applicationStatus` с интервалом 10–30 сек.
- При удалении app через API — Dokploy сам убирает Traefik-роуты и контейнер.
