#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
LOG_FILE="$(mktemp)"
export MOCK_LOG_FILE="$LOG_FILE"
export MOCK_PORT="${MOCK_PORT:-18080}"
export OZON_CLIENT_ID="e2e-client"
export OZON_API_KEY="e2e-key"
export OZON_SELLER_BASE_URL="http://127.0.0.1:${MOCK_PORT}"

cleanup() {
  if [ -n "${SERVER_PID:-}" ] && kill -0 "${SERVER_PID}" 2>/dev/null; then
    kill "${SERVER_PID}" 2>/dev/null || true
    wait "${SERVER_PID}" 2>/dev/null || true
  fi
  rm -f "$LOG_FILE"
}
trap cleanup EXIT

python3 "${SCRIPT_DIR}/mock_server.py" &
SERVER_PID="$!"
sleep 1

export ROOT_DIR
python3 - <<'PY'
import json
import os
import subprocess
from pathlib import Path

root = Path(os.environ["ROOT_DIR"])
manifest = json.load(open(root / "references/catalog/methods.json", "r", encoding="utf-8"))

seen = set()
for item in manifest:
    key = (item["http_method"], item["path"])
    if key in seen:
        raise SystemExit(f"Duplicate method/path in manifest: {key}")
    seen.add(key)

    script = root / item["script_relpath"]
    if not script.exists():
        raise SystemExit(f"Missing wrapper: {script}")
    if not os.access(script, os.X_OK):
        raise SystemExit(f"Wrapper not executable: {script}")

    cmd = [str(script)]
    if item["http_method"] != "GET":
        cmd.extend(["--data", "{}"])
    try:
        subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=5)
    except subprocess.TimeoutExpired as exc:
        raise SystemExit(f"Wrapper timed out: {script}") from exc
PY

python3 - "$LOG_FILE" "$ROOT_DIR/references/catalog/methods.json" <<'PY'
import json
import sys

log_path = sys.argv[1]
manifest_path = sys.argv[2]

rows = [json.loads(line) for line in open(log_path, "r", encoding="utf-8") if line.strip()]
manifest = json.load(open(manifest_path, "r", encoding="utf-8"))

actual = {(row["method"], row["path"]) for row in rows}
expected = {(item["http_method"], item["path"]) for item in manifest}

if actual != expected:
    missing = sorted(expected - actual)[:20]
    extra = sorted(actual - expected)[:20]
    raise SystemExit(f"Manifest/log mismatch. Missing={missing} Extra={extra}")

print(f"E2E OK: {len(rows)} wrappers matched manifest")
PY
