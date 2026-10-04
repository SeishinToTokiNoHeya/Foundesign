#!/bin/bash
# Run from any directory; generated files stay under .build/documentation.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"
output_dir="$repo_root/.build/documentation"
mkdir -p "$output_dir"

# 빌드 방식에 따른 출력 경로에서 이전 그래프만 지워 삭제·변경된 심볼이 남지 않게 합니다.
rm -f "$repo_root"/.build/*/symbolgraph/*.symbols.json
swift package dump-symbol-graph --minimum-access-level public --skip-synthesized-members

staging_dir="$(mktemp -d "${TMPDIR:-/tmp}/foundesign-docc.XXXXXX")"
trap 'rm -rf "$staging_dir"' EXIT

for module in FoundesignFoundation FoundesignComponent Foundesign; do
  module_graphs="$staging_dir/$module"
  mkdir -p "$module_graphs"
  # Include this module's extensions to SwiftUI without importing other modules' graphs.
  for graph in "$repo_root"/.build/*/symbolgraph/"$module.symbols.json" \
    "$repo_root"/.build/*/symbolgraph/"$module@"*.symbols.json; do
    if [ -f "$graph" ]; then
      cp "$graph" "$module_graphs/"
    fi
  done
  if [ ! -f "$module_graphs/$module.symbols.json" ]; then
    echo "Missing symbol graph for $module" >&2
    exit 1
  fi
  xcrun docc convert "Sources/$module/$module.docc" \
    --additional-symbol-graph-dir "$module_graphs" \
    --fallback-bundle-identifier "Foundesign.$module" \
    --output-path "$output_dir/$module.doccarchive" \
    --warnings-as-errors
done

echo "Documentation archives: $output_dir"
