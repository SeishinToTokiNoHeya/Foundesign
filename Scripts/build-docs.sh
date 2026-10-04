#!/bin/bash
# Run from any directory; generated files stay under .build/documentation.
set -euo pipefail

repo_root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_root"
graph_dir="$repo_root/.build/out/symbolgraph"
output_dir="$repo_root/.build/documentation"
mkdir -p "$graph_dir" "$output_dir"

# Only discard generated graphs so removed or renamed symbols cannot linger.
rm -f "$graph_dir/"*.symbols.json
swift package dump-symbol-graph --minimum-access-level public --skip-synthesized-members

staging_dir="$(mktemp -d "${TMPDIR:-/tmp}/foundesign-docc.XXXXXX")"
trap 'rm -rf "$staging_dir"' EXIT

for module in FoundesignFoundation FoundesignComponent Foundesign; do
  module_graphs="$staging_dir/$module"
  mkdir -p "$module_graphs"
  # Include this module's extensions to SwiftUI without importing other modules' graphs.
  for graph in "$graph_dir/$module.symbols.json" "$graph_dir/$module@"*.symbols.json; do
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
