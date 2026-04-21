#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
QUERY="${1:-}"

if [ -z "$QUERY" ] || [ "$QUERY" = "--help" ]; then
  echo "Usage: $0 <query>"
  echo "Examples:"
  echo "  $0 'product list'"
  echo "  $0 '/v3/product/list'"
  echo "  $0 'question list'"
  exit 0
fi

python3 - "$SCRIPT_DIR/../references/catalog/methods.json" "$QUERY" <<'PY'
import json
import sys

manifest_path = sys.argv[1]
query = sys.argv[2].lower()
query_parts = [part for part in query.replace("/", " ").replace("-", " ").replace("_", " ").split() if part]

def normalize(value: str) -> str:
    return value.lower().replace("/", " ").replace("-", " ").replace("_", " ")

data = json.load(open(manifest_path, "r", encoding="utf-8"))
hits = []
for item in data:
    category = normalize(item["category"])
    method_name = normalize(item["method_name"])
    path = normalize(item["path"])
    summary = normalize(item["summary"])
    script = normalize(item["script_relpath"])
    source_title = normalize(item.get("source_title", ""))
    haystack = " ".join([category, method_name, path, summary, script, source_title, item["http_method"].lower()])

    score = 0
    if query in item["path"].lower():
        score += 100
    if query in item["method_name"].lower():
        score += 80
    if query in haystack:
        score += 40

    for part in query_parts:
        if part == category:
            score += 40
        elif part in category:
            score += 20
        if part in method_name:
            score += 30
        if part in path:
            score += 25
        if part in source_title:
            score += 20
        if part in summary:
            score += 10

    if query_parts and not all(part in haystack for part in query_parts):
        continue
    if score > 0:
        hits.append((score, item))

if not hits:
    print("No methods found.")
    raise SystemExit(1)

for _, item in sorted(hits, key=lambda pair: (-pair[0], pair[1]["category"], pair[1]["path"], pair[1]["method_name"]))[:50]:
    print(f'{item["category"]}\t{item["method_name"]}\t{item["http_method"]}\t{item["path"]}\t{item["script_relpath"]}')
PY
