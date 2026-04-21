#!/usr/bin/env python3
from __future__ import annotations

import json
import os
from http.server import BaseHTTPRequestHandler, HTTPServer


LOG_FILE = os.environ["MOCK_LOG_FILE"]
PORT = int(os.environ.get("MOCK_PORT", "18080"))


class Handler(BaseHTTPRequestHandler):
    def _handle(self) -> None:
        length = int(self.headers.get("Content-Length", "0") or "0")
        body = self.rfile.read(length).decode("utf-8") if length else ""
        record = {
            "method": self.command,
            "path": self.path,
            "body": body,
        }
        with open(LOG_FILE, "a", encoding="utf-8") as fh:
            fh.write(json.dumps(record, ensure_ascii=False) + "\n")

        response = {
            "ok": True,
            "method": self.command,
            "path": self.path,
            "echo_body": body,
        }
        encoded = json.dumps(response, ensure_ascii=False).encode("utf-8")
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(encoded)))
        self.end_headers()
        self.wfile.write(encoded)

    do_GET = _handle
    do_POST = _handle
    do_PUT = _handle
    do_DELETE = _handle
    do_PATCH = _handle

    def log_message(self, fmt: str, *args) -> None:
        return


if __name__ == "__main__":
    server = HTTPServer(("127.0.0.1", PORT), Handler)
    server.serve_forever()
