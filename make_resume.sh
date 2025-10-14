#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURATION ===
INPUT_FILE="${1:-}"
CUSTOM_TEMPLATE="${2:-}"
CUSTOM_OUTDIR="${3:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Defaults
DEFAULT_TEMPLATE="$SCRIPT_DIR/examples/template.latex"
DEFAULT_OUTPUT_DIR="$SCRIPT_DIR/output"

# Resolve effective paths
TEMPLATE="${CUSTOM_TEMPLATE:-$DEFAULT_TEMPLATE}"
OUTPUT_DIR="${CUSTOM_OUTDIR:-$DEFAULT_OUTPUT_DIR}"

# === VALIDATION ===
if [[ -z "$INPUT_FILE" ]]; then
  echo "❌ Usage: bash make_resume.sh <markdown-file> [optional-template] [optional-output-dir]"
  echo "Examples:"
  echo "  bash make_resume.sh examples/example_resume.md"
  echo "  bash make_resume.sh examples/example_resume.md templates/modern.latex"
  echo "  bash make_resume.sh examples/example_resume.md templates/modern.latex dist/"
  exit 1
fi

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "❌ File not found: $INPUT_FILE"
  exit 1
fi

if [[ ! -f "$TEMPLATE" ]]; then
  echo "❌ Template not found: $TEMPLATE"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# === Output filenames ===
BASE_NAME="$(basename "$INPUT_FILE" .md)"
PDF_OUT="$OUTPUT_DIR/${BASE_NAME}.pdf"
DOCX_OUT="$OUTPUT_DIR/${BASE_NAME}.docx"

echo "🔧 Building resume for $INPUT_FILE..."
echo "🧩 Using template: $TEMPLATE"
echo "📁 Output directory: $OUTPUT_DIR"

# === Generate PDF ===
echo "📄 Generating PDF..."
if ! pandoc "$INPUT_FILE" \
  --from markdown+raw_tex \
  --template="$TEMPLATE" \
  --pdf-engine=xelatex \
  --output="$PDF_OUT" \
  --metadata=title:"" --metadata=author:""; then
  echo "❌ PDF generation failed."
  exit 1
fi

# === Generate DOCX ===
echo "📄 Generating DOCX..."
if ! pandoc "$INPUT_FILE" \
  --from markdown+raw_tex \
  --to docx \
  --output="$DOCX_OUT" \
  --metadata=title:"" --metadata=author:""; then
  echo "❌ DOCX generation failed."
  exit 1
fi

echo "✅ Build complete!"
echo "   PDF:  $PDF_OUT"
echo "   DOCX: $DOCX_OUT"