#!/usr/bin/env python3
# claude_prettier_hook.py -- Claude Code PostToolUse hook: format edited files
# Author - Ben Glasner (scaffolded 2026-08-10)
# Purpose - After Claude edits or writes a file, run Prettier on that file so the
#           "run npx prettier before commit" rule is automatic instead of manual.
# Notes   - Reads the hook payload as JSON on stdin. Never blocks the edit: any
#           failure exits 0 so a Prettier problem surfaces at commit time, not
#           mid-edit. Prettier itself respects .prettierignore.

from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

FORMATTABLE_SUFFIXES = {
    ".md",
    ".yml",
    ".yaml",
    ".json",
    ".js",
    ".html",
    ".liquid",
    ".scss",
    ".css",
}


def main() -> int:
    try:
        payload = json.load(sys.stdin)
    except (json.JSONDecodeError, ValueError):
        return 0

    file_path = (payload.get("tool_input") or {}).get("file_path", "")
    if not file_path:
        return 0

    path = Path(file_path)
    if path.suffix.lower() not in FORMATTABLE_SUFFIXES or not path.exists():
        return 0

    project_dir = Path(payload.get("cwd") or Path(__file__).resolve().parent.parent)

    try:
        subprocess.run(
            ["npx", "prettier", "--write", "--ignore-unknown", str(path)],
            cwd=project_dir,
            capture_output=True,
            timeout=60,
            check=False,
        )
    except (OSError, subprocess.TimeoutExpired):
        pass

    return 0


if __name__ == "__main__":
    sys.exit(main())
