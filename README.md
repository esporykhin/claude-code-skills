# claude-code-skills

Claude Code skills for working with MPSTATS — the leading analytics platform for Russian marketplaces (Wildberries, Ozon).

## Available Skills

### `mpstats`

Provides Claude Code with deep context about the MPSTATS platform:

- REST API reference (endpoints, authentication, response formats)
- ClickHouse table schemas (`wbsubjectsstats`, `dm_items_summary`, `dm_trend`)
- AI assistant architecture (nicheExpert intent-based API)
- Code patterns for TypeScript and Python integrations
- SQL patterns for niche analysis
- PostgreSQL schema for AI assistant analytics

**Triggers automatically when you:**
- Work on MPSTATS integrations
- Build WB/Ozon analytics features
- Implement niche search or product analysis
- Query marketplace data

**Or invoke directly:** `/mpstats:mpstats`

## Installation

### Option 1: Add as a marketplace (recommended)

Inside Claude Code, run:

```
/plugin marketplace add esporykhin/claude-code-skills
```

Then install the skill:

```
/plugin install mpstats@esporykhin-claude-skills
```

### Option 2: Clone locally for development

```bash
cd your-project
git clone https://github.com/esporykhin/claude-code-skills .claude-skills
claude --plugin-dir .claude-skills
```

### Option 3: Add to project settings

Add to `.claude/settings.json` in your project:

```json
{
  "extraKnownMarketplaces": {
    "esporykhin-claude-skills": {
      "source": {
        "source": "github",
        "repo": "esporykhin/claude-code-skills"
      }
    }
  }
}
```

## What Claude learns from the mpstats skill

1. **API patterns** — how to authenticate and call MPSTATS REST API
2. **Data models** — ClickHouse table schemas with field descriptions
3. **AI architecture** — how nicheExpert intent-based service works
4. **SQL patterns** — common queries for niche analysis
5. **Integration code** — TypeScript and Python examples
6. **Business domain** — WB subjects, sellers, SKUs, niche metrics

## Requirements

- Claude Code 1.0.33+
- Access to MPSTATS API (for actual API calls)
- VPN/SSH tunnel to MPSTATS network (for ClickHouse access)

## License

MIT
