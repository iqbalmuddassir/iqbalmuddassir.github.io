#!/usr/bin/env bash
# Capture high-DPI SpaceBar UI screenshots from the local HTML mockup, plus
# light/dark shots of the portfolio page. Uses the Chrome oneshot wrapper from
# .cursor/environment.json (temp profile, --force-device-scale-factor=2).
#
# Usage (docs server must serve docs/ on :8000):
#   python3 -m http.server 8000 --directory docs &
#   bash docs/spacebar/capture-page-screenshots.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
OUT="$ROOT/assets"
mkdir -p "$OUT"

BASE="${SPACEBAR_BASE_URL:-http://127.0.0.1:8000/spacebar}"
WIDTH="${SHOT_WIDTH:-1260}"
HEIGHT="${SHOT_HEIGHT:-900}"

if ! curl -fsS "$BASE/" >/dev/null; then
  echo "Docs server not reachable at $BASE/"
  echo "Start it with: python3 -m http.server 8000 --directory docs"
  exit 1
fi

capture() {
  local name="$1"
  local url="$2"
  local w="${3:-$WIDTH}"
  local h="${4:-$HEIGHT}"
  local scale="${5:-2}"
  google-chrome \
    --headless=new \
    --hide-scrollbars \
    --force-device-scale-factor="$scale" \
    --window-size="${w},${h}" \
    --virtual-time-budget=12000 \
    --screenshot="$OUT/${name}.png" \
    "$url"
  if [[ ! -s "$OUT/${name}.png" ]]; then
    echo "Failed to write $OUT/${name}.png"
    exit 1
  fi
  echo "  captured ${name}.png ($(wc -c < "$OUT/${name}.png") bytes)"
}

echo "Capturing SpaceBar UI mockups (2x) → $OUT"
capture "issues"   "$BASE/mockup.html?view=issues"
capture "settings" "$BASE/mockup.html?view=settings"

PROOF="${SPACEBAR_PROOF_DIR:-/tmp/spacebar-page-proofs}"
mkdir -p "$PROOF"
echo "Capturing portfolio page light/dark proofs → $PROOF"
OUT="$PROOF" capture "page-light" "$BASE/?theme=light" 1440 1800 1
OUT="$PROOF" capture "page-dark"  "$BASE/?theme=dark"  1440 1800 1

echo "Done."
