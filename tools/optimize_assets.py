#!/usr/bin/env python3
"""Generate bundled assets from the original fonts and sounds kept in app/assets.

Requires fontTools, ffmpeg and ffprobe. Run again after editing TipsDialog text.
"""

import json
from pathlib import Path
import subprocess
import tempfile

from fontTools import subset
from fontTools.ttLib import TTFont


APP = Path(__file__).resolve().parents[1] / "app"
ASSETS = APP / "assets"
OUTPUT = ASSETS / "optimized"


def run(*args):
    return subprocess.run(args, check=True, capture_output=True, text=True).stdout


def audio_metadata(path):
    return json.loads(run(
        "ffprobe", "-v", "error", "-show_entries",
        "format=duration:stream=codec_name,sample_rate,channels", "-of", "json", str(path),
    ))


def main():
    # Only TipsDialog uses these two families; user-entered text uses system fonts.
    text = (APP / "lib/ui/widget/tips_dialog.dart").read_text(encoding="utf-8")
    codepoints = set(map(ord, text)) | set(range(0x20, 0x7F))
    report = {"fonts": [], "audio": []}
    font_output = OUTPUT / "fonts"
    font_output.mkdir(parents=True, exist_ok=True)
    for name in ("NotoSansTC-Bold.otf", "MaShanZheng-Regular.ttf"):
        source = ASSETS / "fonts" / name
        destination = font_output / name
        font = TTFont(source, recalcTimestamp=False)
        required = codepoints & font.getBestCmap().keys()
        options = subset.Options()
        options.name_IDs = ["*"]  # Preserve copyright and license metadata.
        subsetter = subset.Subsetter(options=options)
        subsetter.populate(unicodes=required)
        subsetter.subset(font)
        font.save(destination)
        font.close()
        with TTFont(destination) as bundled:
            missing = required - bundled.getBestCmap().keys()
            if missing:
                raise ValueError(f"Font coverage lost: {name}: {sorted(missing)}")
        report["fonts"].append({
            "name": name, "before": source.stat().st_size,
            "after": destination.stat().st_size, "characters": len(required),
        })

    audio_output = OUTPUT / "musics"
    audio_output.mkdir(parents=True, exist_ok=True)
    for source in sorted((ASSETS / "musics").glob("*.mp3")):
        destination = audio_output / source.name
        before = audio_metadata(source)
        # Keep the complete recording, its sample rate, stereo channels and MP3 paths.
        # Use a temporary file so interrupted conversions cannot leave a partial asset.
        with tempfile.TemporaryDirectory() as directory:
            temporary = Path(directory) / source.name
            run("ffmpeg", "-v", "error", "-y", "-i", str(source),
                "-map_metadata", "-1", "-c:a", "libmp3lame", "-b:a", "96k",
                str(temporary))
            after = audio_metadata(temporary)
            if abs(float(before["format"]["duration"]) - float(after["format"]["duration"])) > 0.1:
                raise ValueError(f"Audio duration changed: {source.name}")
            if before["streams"] != after["streams"]:
                raise ValueError(f"Audio format changed: {source.name}")
            run("ffmpeg", "-v", "error", "-i", str(temporary), "-f", "null", "-")
            destination.write_bytes(temporary.read_bytes())
        report["audio"].append({
            "name": source.name, "before": source.stat().st_size,
            "after": destination.stat().st_size,
            "duration_seconds": float(after["format"]["duration"]),
        })
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
