# Application — payload reference

## `application.create` (POST)

```json
{
  "name": "myapp",
  "appName": "myapp",
  "description": "string",
  "environmentId": "<envId>",
  "serverId": "<serverId>"
}
```

Возвращает полный объект application с `applicationId` и сгенерированным `appName` (с суффиксом).

`serverId` опционален — без него app деплоится на сам Dokploy-инстанс.

## `application.update` (POST)

Принимает `applicationId` + любой набор полей объекта. Полезные:

| Поле | Тип | Описание |
|------|-----|---------|
| `autoDeploy` | bool | автодеплой по webhook git-провайдера |
| `triggerType` | `"push"` \| `"tag"` | условие запуска |
| `env` | string | весь блок env (KEY=VALUE\\n) |
| `buildArgs` | string | docker build args |
| `buildSecrets` | string | docker build secrets |
| `dockerfile` | string | путь к Dockerfile внутри context |
| `dockerContextPath` | string | docker build context |
| `dockerBuildStage` | string | --target |
| `cleanCache` | bool | очищать docker cache при билде |
| `previewPort` | int | внутренний порт приложения |
| `memoryLimit` / `cpuLimit` | int | swarm-лимиты |

## `application.saveGithubProvider` (POST)

```json
{
  "applicationId": "...",
  "githubId": "<provider's github.githubId>",
  "owner": "esporykhin",
  "repository": "my-repo",
  "branch": "main",
  "buildPath": "/",
  "watchPaths": []
}
```

Источник переключается на GitHub App. autoDeploy будет работать через webhooks GitHub-приложения, secret хранится в Dokploy.

## `application.saveGitProvider` (POST)

```json
{
  "applicationId": "...",
  "sourceType": "git",
  "customGitUrl": "git@github.com:owner/repo.git",
  "customGitBranch": "main",
  "customGitBuildPath": "/",
  "customGitSSHKeyId": "<sshKeyId>",
  "watchPaths": [],
  "enableSubmodules": false
}
```

Для приватного репо — обязательно `customGitSSHKeyId`. Public ключ из Dokploy (`sshKey.one?sshKeyId=...`) добавь в **Settings → Deploy keys** на GitHub.

## `application.saveBuildType` (POST)

```json
{
  "applicationId": "...",
  "buildType": "dockerfile",
  "dockerfile": "Dockerfile",
  "dockerContextPath": ".",
  "dockerBuildStage": "",
  "herokuVersion": "24",
  "railpackVersion": "latest"
}
```

`buildType`: `dockerfile` | `nixpacks` | `heroku_buildpacks` | `paketo_buildpacks` | `static` | `railpack`.

## `application.deploy` (POST)

```json
{ "applicationId": "..." }
```

Запускает: clone repo → build → запуск в swarm/docker. Сразу возвращает 200; статус читай через `application.one`.

## `application.one` (GET)

`?applicationId=...` — возвращает полную карточку. Ключевые поля:

| Поле | Описание |
|------|---------|
| `applicationStatus` | `idle`/`running`/`done`/`error` |
| `sourceType` | `github`/`gitlab`/`bitbucket`/`gitea`/`git`/`docker` |
| `repository`/`owner`/`branch`/`buildPath` | для GitHub-источника |
| `customGitUrl`/`customGitBranch`/`customGitSSHKeyId` | для custom git |
| `dockerImage`/`registryUrl` | для docker-источника |
| `domains[]` | подключённые домены |
| `appName` | имя контейнера/стека на сервере |

## Жизненный цикл

```
create → saveGithubProvider/saveGitProvider → saveBuildType → domain.create → update(env) → deploy
                                                                                              ↓
                                                                               applicationStatus: running
                                                                                              ↓
                                                                                            done | error
```
