#!/usr/bin/env python3
"""Report actual bytes stored inside one or more APKs (not installed app size)."""

import argparse
from collections import defaultdict
import hashlib
import json
from pathlib import Path
import zipfile


def inspect_apk(path):
    groups = defaultdict(lambda: {"raw_bytes": 0, "apk_bytes": 0, "files": 0})
    with zipfile.ZipFile(path) as archive:
        entries = archive.infolist()
        for entry in entries:
            name = entry.filename
            if name.startswith("lib/"):
                group = "native"
            elif name.startswith("assets/flutter_assets/assets/") and "/fonts/" in name:
                group = "fonts"
            elif name.startswith("assets/flutter_assets/assets/") and "/musics/" in name:
                group = "audio"
            else:
                group = "other"
            groups[group]["raw_bytes"] += entry.file_size
            groups[group]["apk_bytes"] += entry.compress_size
            groups[group]["files"] += 1
        groups["zip_and_signing"]["apk_bytes"] = path.stat().st_size - sum(
            entry.compress_size for entry in entries
        )
        largest = [{"path": entry.filename, "apk_bytes": entry.compress_size}
                   for entry in sorted(entries, key=lambda entry: entry.compress_size, reverse=True)[:10]]
    return {
        "path": str(path), "bytes": path.stat().st_size,
        "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
        "groups": dict(groups), "largest": largest,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("apks", nargs="+", type=Path)
    arguments = parser.parse_args()
    print(json.dumps([inspect_apk(path) for path in arguments.apks], indent=2))
