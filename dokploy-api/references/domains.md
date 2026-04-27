# Domains

Dokploy управляет роутингом через встроенный `dokploy-traefik`. Каждый домен — запись в Traefik dynamic config, генерируется автоматически.

## `domain.create` (POST)

```json
{
  "applicationId": "...",
  "host": "example.com",
  "https": true,
  "port": 3000,
  "path": "/",
  "certificateType": "letsencrypt",
  "domainType": "application",
  "internalPath": "/",
  "stripPath": false
}
```

Поля:

| Поле | Описание |
|------|---------|
| `host` | домен (без протокола) |
| `port` | внутренний порт контейнера, на который роутится трафик |
| `https` | true → автоматический redirect HTTP→HTTPS + LE-сертификат |
| `path` | path-префикс снаружи (для основного домена `/`) |
| `internalPath` | path внутри контейнера, куда мапить (если приложение слушает на под-пути) |
| `stripPath` | срезать ли `path` перед отправкой запроса в контейнер |
| `certificateType` | `letsencrypt` \| `none` \| кастомный resolver |
| `customCertResolver` | имя своего LE/DNS resolver-а в `traefik.yml` |
| `domainType` | `application` \| `compose` \| `previewDeployment` |

DNS должен резолвиться в IP сервера, на котором живёт application (или Dokploy host, если `serverId=null`). Иначе LE не выдаст сертификат.

## Несколько доменов

Просто создай ещё один — на тот же `applicationId`. Например для `iamteya.ru` + `www.iamteya.ru` — два вызова `domain.create`.

## `domain.update` / `domain.delete`

```bash
./scripts/dokploy-request.sh POST domain.update --data '{"domainId":"...","port":4000}'
./scripts/dokploy-request.sh POST domain.delete --data '{"domainId":"..."}'
```

## `domain.byApplicationId`

```bash
./scripts/dokploy-request.sh GET domain.byApplicationId --query 'applicationId=...'
```

Возвращает все домены конкретного application.
