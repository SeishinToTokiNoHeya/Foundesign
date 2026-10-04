#!/usr/bin/env python3
"""Validate repository document paths and the small feature catalog (stdlib only)."""

import json
from pathlib import Path
import re
import sys
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parent.parent
errors = []


def check_path(raw, origin, *, file_only=False):
    """Reject missing paths and paths that escape the repository, including symlinks."""
    if not isinstance(raw, str) or not raw:
        errors.append(f"{origin}: expected a nonempty path string")
        return
    path = Path(raw)
    target = (ROOT / path).resolve()
    if path.is_absolute() or ROOT not in target.parents:
        errors.append(f"{origin}: path must stay inside the repository: {raw}")
    elif not (target.is_file() if file_only else target.exists()):
        errors.append(f"{origin}: missing path: {raw}")


def check_catalog():
    catalog_path = ROOT / "docs/ai/catalog.json"
    try:
        catalog = json.loads(catalog_path.read_text())
    except (OSError, ValueError) as error:
        errors.append(f"catalog: {error}")
        return
    if not isinstance(catalog, dict) or catalog.get("schema_version") != 1:
        errors.append("catalog: expected schema_version 1")
        return
    entries = catalog.get("entries")
    if not isinstance(entries, list) or not entries:
        errors.append("catalog: entries must be a nonempty array")
        return
    seen = set()
    for index, entry in enumerate(entries):
        origin = f"catalog entry {index}"
        if not isinstance(entry, dict):
            errors.append(f"{origin}: expected an object")
            continue
        identifier = entry.get("id")
        if not isinstance(identifier, str) or not re.fullmatch(r"[a-z][a-z0-9.-]*", identifier):
            errors.append(f"{origin}: invalid id")
        elif identifier in seen:
            errors.append(f"{origin}: duplicate id {identifier}")
        else:
            seen.add(identifier)
        module = entry.get("module")
        if module not in ("Foundesign", "FoundesignFoundation", "FoundesignComponent"):
            errors.append(f"{origin}: unknown module {module}")
        for field in ("source_paths", "documentation_paths", "example_paths"):
            paths = entry.get(field)
            if not isinstance(paths, list) or (field != "example_paths" and not paths):
                errors.append(f"{origin}: invalid {field}")
                continue
            for path in paths:
                check_path(path, f"{origin}.{field}", file_only=True)
                if isinstance(path, str):
                    prefix = "Example/" if field == "example_paths" else f"Sources/{module}/"
                    if not path.startswith(prefix):
                        errors.append(f"{origin}.{field}: expected path under {prefix}")
        expected_status = "available" if entry.get("example_paths") else "missing"
        if entry.get("example_status") != expected_status:
            errors.append(f"{origin}: example_status must be {expected_status}")


def check_markdown():
    # Covers inline links used in these guides; DocC resolves its own symbol/article links.
    documents = [ROOT / "README.md", ROOT / "AGENTS.md", ROOT / "Example/AGENTS.md"]
    documents += list((ROOT / "docs").rglob("*.md"))
    documents += list((ROOT / "Sources").rglob("*.md"))
    for document in documents:
        content = document.read_text()
        content = re.sub(r"^```.*?^```[^\n]*$", "", content, flags=re.MULTILINE | re.DOTALL)
        for match in re.finditer(r"\[[^\]\n]*\]\(([^)\n]+)\)", content):
            destination = match.group(1).strip().strip("<>")
            url = urlsplit(destination)
            if url.scheme or url.netloc or not url.path:
                continue
            raw = unquote(url.path)
            if Path(raw).is_absolute():
                errors.append(f"{document.relative_to(ROOT)}: use a relative link: {raw}")
                continue
            relative = (document.parent / raw).relative_to(ROOT)
            check_path(str(relative), str(document.relative_to(ROOT)))


check_catalog()
check_markdown()
if errors:
    print("\n".join(errors), file=sys.stderr)
    sys.exit(1)
print("Documentation links and feature catalog are valid.")
