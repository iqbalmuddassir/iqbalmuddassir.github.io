#!/usr/bin/env bash
# Capture light/dark marketing screenshots of the SpaceBar portfolio page via headless Chrome.
# Relies on the oneshot wrapper installed by .cursor/environment.json (temp Chrome profile).
#
# Usage (docs server must be serving docs/ on :8000):
#   python3 -m http.server 8000 --directory docs &
#   bash docs/spacebar/capture-page-screenshots.sh
#
# App UI snapshots from the local SpaceBar checkout (Swift SnapshotTesting / manual
# captures) can be dropped into docs/spacebar/assets/ and wired into index.html —
# same pattern as docs/quran-education-app/android/capture-device-screenshots.sh.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/assets"
mkdir -p "$OUT"

BASE_URL="${SPACEBAR_PAGE_URL:-http://127.0.0.1:8000/spacebar/}"
WIDTH="${SHOT_WIDTH:-1440}"
HEIGHT="${SHOT_HEIGHT:-1800}"

if ! curl -fsS "$BASE_URL" >/dev/null; then
  echo "Docs server not reachable at $BASE_URL"
  echo "Start it with: python3 -m http.server 8000 --directory docs"
  exit 1
fi

capture() {
  local name="$1"
  local theme="$2"
  local url="${BASE_URL}?theme=${theme}"
  google-chrome \
    --headless=new \
    --screenshot="$OUT/${name}.png" \
    --window-size="${WIDTH},${HEIGHT}" \
    --hide-scrollbars \
    --virtual-time-budget=8000 \
    "$url"
  if [[ ! -s "$OUT/${name}.png" ]]; then
    echo "Failed to write $OUT/${name}.png"
    exit 1
  fi
  echo "  captured ${name}.png ($(wc -c < "$OUT/${name}.png") bytes)"
}

echo "Capturing SpaceBar page shots → $OUT"
capture "page-light" "light"
capture "page-dark" "dark"
echo "Done."
