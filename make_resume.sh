#!/usr/bin/env bash
set -euo pipefail

INPUT=${1:-examples/example_resume.md}
OUTPUT_DIR=${2:-output}
TEMPLATE=${3:-examples/template.latex}
METADATA=${4:-examples/metadata.yaml}
PDF_OUT=${5:-resume.pdf}
DOCX_OUT=${6:-resume.docx}

echo "🔧 Building resume for $INPUT..."

need() { command -v "$1" >/dev/null 2>&1 || { echo "❌ Missing: $1"; exit 1; }; }
need pandoc
need xelatex

mkdir -p "$OUTPUT_DIR"

# # Check LaTeX packages (BasicTeX users)
# if command -v tlmgr >/dev/null 2>&1; then
#   missing_pkgs=()
#   for pkg in titlesec xcolor enumitem fontspec geometry hyperref url; do
#     tlmgr info "$pkg" | grep -qi "installed.*yes" || missing_pkgs+=("$pkg")
#   done
#   if [ ${#missing_pkgs[@]} -gt 0 ]; then
#     echo "❌ Missing LaTeX packages: ${missing_pkgs[*]}"
#     echo "👉 Install with: sudo tlmgr update --self && sudo tlmgr install ${missing_pkgs[*]}"
#     exit 1
#   fi
# fi

# PDF
echo "📄 Generating PDF..."
pandoc "$INPUT" \
  --from markdown \
  --template="$TEMPLATE" \
  --metadata-file="$METADATA" \
  --pdf-engine=xelatex \
  -o "$OUTPUT_DIR/$PDF_OUT"

# DOCX
echo "📄 Generating DOCX..."
pandoc "$INPUT" \
  --from markdown \
  --metadata-file="$METADATA" \
  -o "$OUTPUT_DIR/$DOCX_OUT"

echo "✅ Build complete!"
echo "   PDF:  $OUTPUT_DIR/$PDF_OUT"
echo "   DOCX: $OUTPUT_DIR/$DOCX_OUT"