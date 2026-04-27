# Git providers (GitHub / GitLab / Bitbucket / Gitea)

В Dokploy есть два разных способа подключить репо к application:

1. **Git provider integration** (GitHub App, GitLab OAuth, и т.п.) — webhooks, автодеплой по push, доступ ко всем репозиториям организации одной установкой.
2. **Custom git** (по SSH-ключу или basic auth) — любой git-сервер; webhook нужно настроить руками.

Используй (1), если репо живёт в поддерживаемом провайдере — это даёт полноценный CI/CD.

## Список провайдеров

```bash
./scripts/methods/git-providers-list.sh
```

Возвращает массив объектов:

```json
{
  "gitProviderId": "...",
  "name": "Dokploy-2026-04-13-lyw3qs",
  "providerType": "github" | "gitlab" | "bitbucket" | "gitea",
  "github": { "githubId": "...", "githubAppId": ..., "githubInstallationId": "..." },
  "gitlab": null,
  "bitbucket": null,
  "gitea": null
}
```

Для GitHub используется в `application.saveGithubProvider` поле `githubId` — это `github.githubId` из ответа выше (НЕ `gitProviderId`).

## Как создать GitHub App в Dokploy

Через UI: **Settings → Git Providers → GitHub → Create GitHub App** → авторизуешь его на свою organization/account, выбираешь к каким репо имеет доступ. После этого в API появится новый `gitProvider`.

Через API процесс не автоматизируется — нужен пользовательский OAuth flow.

## Репозитории, доступные provider-у

```bash
./scripts/methods/github-repos.sh <githubId>
# или для полного JSON
./scripts/methods/github-repos.sh <githubId> --full
```

Если нужного репо в списке нет — открой GitHub App в settings GitHub-аккаунта, в **Repository access** добавь репо.

## Custom git

Если в репозитории нет связанного провайдера, или это самописный gitea/local git:

1. Получи SSH-ключ: `./scripts/methods/sshkey-list.sh` → `publicKey`
2. Добавь его в Deploy Keys репозитория (read-only достаточно):
   ```bash
   gh repo deploy-key add /tmp/key.pub --repo owner/repo --title "dokploy"
   ```
3. Привяжи источник:
   ```bash
   ./scripts/methods/app-set-git-source.sh <appId> git@github.com:owner/repo.git main / <sshKeyId>
   ```

Webhook для autoDeploy при custom git нужно повесить вручную: эндпоинт у Dokploy — `POST <DOKPLOY_URL>/api/deploy/<applicationId>` с заголовком `x-api-key`.

## Переключение источника

`application.saveGithubProvider` и `application.saveGitProvider` обе изменяют `sourceType` на свой. Можно переключаться туда-обратно — старые поля остаются в БД, но активным считается тот, что соответствует `sourceType`.
