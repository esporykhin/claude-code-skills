---
name: dokploy-api
description: Dokploy API — управление self-hosted PaaS (приложения, проекты, домены, деплой). Use when пользователь просит задеплоить/обновить приложение в Dokploy, привязать домен, переключить git-источник, посмотреть статус, или сделать произвольный API-вызов к Dokploy.
---

# Dokploy API

Скилл для работы с Dokploy через готовые bash-скрипты. API у Dokploy — tRPC, эндпоинты вида `/api/<resource>.<action>`, авторизация через заголовок `x-api-key`.

## Workflow

1. Проверь `config/.env`. Если нет — запусти onboarding (см. [config/README.md](config/README.md)).
2. Используй готовые методы из `scripts/methods/`.
3. Для эндпоинта, которого нет в `methods/` — `./scripts/dokploy-request.sh METHOD procedure [--data '{...}']`.
4. Перед write-операцией прочитай объект через `app-status.sh` или `dokploy-request.sh GET ...one --query 'id=...'`.

## Authentication

```
Header: x-api-key: <DOKPLOY_API_KEY>
```

Токен делается в Dokploy UI → **Settings → API/CLI → Generate Token**. Хранится в `config/.env` (gitignore).

Переменные:
- `DOKPLOY_URL` — `http://host:port` или `https://host`, без trailing slash
- `DOKPLOY_API_KEY` — long-lived API token

Переменные окружения переопределяют `config/.env` на один вызов.

## Готовые методы

### Проекты и серверы

| Скрипт | Назначение |
|--------|------------|
| `methods/project-list.sh` | Список проектов с приложениями и compose |
| `methods/project-create.sh <name> [desc]` | Создать проект |
| `methods/server-list.sh` | Список remote-серверов |

### Git-провайдеры

| Скрипт | Назначение |
|--------|------------|
| `methods/git-providers-list.sh` | Список git-провайдеров (GitHub Apps, GitLab, и т.п.) |
| `methods/github-repos.sh <githubId>` | Репозитории, доступные GitHub App |
| `methods/sshkey-list.sh` | SSH-ключи Dokploy (для custom git) |

### Applications

| Скрипт | Назначение |
|--------|------------|
| `methods/app-create.sh <name> <envId> [--server <id>] [--description ...]` | Создать application в environment |
| `methods/app-set-github-source.sh <appId> <githubId> <owner> <repo> [branch] [buildPath]` | Привязать к GitHub App-провайдеру (автодеплой по push) |
| `methods/app-set-git-source.sh <appId> <gitUrl> [branch] [buildPath] [sshKeyId]` | Привязать к произвольному git (через SSH-ключ) |
| `methods/app-set-build-type.sh <appId> <type> [--dockerfile path] [--context dir] [--stage name]` | Тип билда (`dockerfile`/`nixpacks`/...) |
| `methods/app-update.sh <appId> <jsonPatch>` | Обновить произвольные поля (autoDeploy, env, и т.п.) |
| `methods/app-set-env.sh <appId> [envFile]` | Записать env-блок (или из stdin) |
| `methods/app-deploy.sh <appId>` | Запустить деплой (clone + build + run) |
| `methods/app-redeploy.sh <appId>` | Перезапустить из существующего image |
| `methods/app-stop.sh <appId>` | Остановить контейнер |
| `methods/app-start.sh <appId>` | Запустить остановленный |
| `methods/app-status.sh <appId> [--full]` | Сводка/полная карточка application |
| `methods/app-delete.sh <appId>` | Удалить app |

### Домены

| Скрипт | Назначение |
|--------|------------|
| `methods/domain-create.sh <appId> <host> [--port N] [--http-only] [--cert letsencrypt\|none]` | Прикрутить домен с Let's Encrypt по умолчанию |
| `methods/domain-delete.sh <domainId>` | Удалить домен |

## Универсальный вызов

```bash
./scripts/dokploy-request.sh GET  project.all
./scripts/dokploy-request.sh GET  application.one --query 'applicationId=abc123'
./scripts/dokploy-request.sh POST application.deploy --data '{"applicationId":"abc123"}'
./scripts/dokploy-request.sh POST domain.create --data '{"applicationId":"abc","host":"x.com","https":true,"port":3000,"path":"/","certificateType":"letsencrypt","domainType":"application"}'
```

## Полный сценарий: новый сайт под Dokploy с GitHub-автодеплоем

```bash
# 1. Создать проект
./scripts/methods/project-create.sh "MySite"
# → projectId, environmentId

# 2. Найти GitHub-провайдера (githubId) и сервер (serverId, опционально)
./scripts/methods/git-providers-list.sh
./scripts/methods/server-list.sh

# 3. Убедиться что репо доступен GitHub App
./scripts/methods/github-repos.sh <githubId> | grep my-repo

# 4. Создать application
./scripts/methods/app-create.sh "mysite" <environmentId> --server <serverId>
# → applicationId

# 5. Привязать GitHub-источник
./scripts/methods/app-set-github-source.sh <appId> <githubId> esporykhin my-repo main /

# 6. Указать тип билда
./scripts/methods/app-set-build-type.sh <appId> dockerfile --dockerfile Dockerfile --context .

# 7. (опц.) env-переменные
./scripts/methods/app-set-env.sh <appId> /path/to/.env.production

# 8. Прикрутить домен
./scripts/methods/domain-create.sh <appId> mysite.com --port 3000

# 9. Включить autoDeploy и сделать первый деплой
./scripts/methods/app-update.sh <appId> '{"autoDeploy":true,"triggerType":"push"}'
./scripts/methods/app-deploy.sh <appId>

# 10. Дождаться done
until [ "$(./scripts/methods/app-status.sh <appId> | jq -r .applicationStatus)" != "running" ]; do sleep 15; done
./scripts/methods/app-status.sh <appId>
```

## Реестр известных tRPC-процедур

Полного OpenAPI Dokploy не отдаёт. Подтверждённые рабочие эндпоинты (на момент написания):

| Procedure | Method | Назначение |
|-----------|--------|------------|
| `project.all` | GET | список проектов |
| `project.create` | POST | создать проект |
| `server.withSSHKey` | GET | список серверов |
| `gitProvider.getAll` | GET | git-провайдеры |
| `github.getGithubRepositories?githubId=...` | GET | репозитории GitHub App |
| `sshKey.all` / `sshKey.one?sshKeyId=...` | GET | SSH-ключи |
| `application.create` | POST | создать app |
| `application.one?applicationId=...` | GET | карточка app |
| `application.update` | POST | произвольный patch |
| `application.saveGithubProvider` | POST | привязать GitHub-источник |
| `application.saveGitProvider` | POST | привязать custom git |
| `application.saveBuildType` | POST | тип билда |
| `application.deploy` | POST | задеплоить |
| `application.redeploy` | POST | перезапустить из image |
| `application.stop` / `application.start` | POST | стоп/старт |
| `application.delete` | POST | удалить |
| `domain.create` / `domain.delete` | POST | домены |

Если нужного эндпоинта нет — пробуй очевидные имена (`<resource>.all`, `<resource>.one`, `<resource>.create`, `<resource>.update`, `<resource>.delete`, и т.п.) через `dokploy-request.sh`. На отсутствующий путь API возвращает `{"code":"NOT_FOUND"}`.

## Гочи

- `application.saveGitProvider` требует поле `watchPaths:[]` (даже пустое).
- `application.saveBuildType` требует поля `herokuVersion` и `railpackVersion` (можно `"24"`/`"latest"`).
- `application.deploy` сразу возвращает 200 и стартует фоновый билд. Статус смотри через `application.one` → `applicationStatus`: `running` → `done`/`error`.
- На remote-серверах логи деплоя лежат в `/etc/dokploy/logs/<appName>/<appName>-<timestamp>.log` (через SSH).
- При удалении app вручную из traefik (`/etc/dokploy/traefik/dynamic/<appName>.yml`) Dokploy перегенерирует конфиг при следующем деплое.

## Ссылки

- Docs: https://docs.dokploy.com
- Source: https://github.com/Dokploy/dokploy
