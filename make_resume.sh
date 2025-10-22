#!/usr/bin/env bash
set -euo pipefail

# === CONFIGURATION ===
INPUT_FILE=""
CUSTOM_TEMPLATE=""
CUSTOM_OUTDIR=""
MODE="normal"
BUILD_DOCX=false

# --- Parse arguments ---
for arg in "$@"; do
  case "$arg" in
    --redacted|-r)
      MODE="redacted"
      ;;
    --docx)
      BUILD_DOCX=true
      ;;
    *)
      if [[ -z "$INPUT_FILE" ]]; then
        INPUT_FILE="$arg"
      elif [[ -z "$CUSTOM_TEMPLATE" ]]; then
        CUSTOM_TEMPLATE="$arg"
      elif [[ -z "$CUSTOM_OUTDIR" ]]; then
        CUSTOM_OUTDIR="$arg"
      fi
      ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Defaults
DEFAULT_TEMPLATE="$SCRIPT_DIR/examples/template.latex"
DEFAULT_OUTPUT_DIR="$SCRIPT_DIR/output"

# Resolve effective paths
TEMPLATE="${CUSTOM_TEMPLATE:-$DEFAULT_TEMPLATE}"
OUTPUT_DIR="${CUSTOM_OUTDIR:-$DEFAULT_OUTPUT_DIR}"

# === VALIDATION ===
if [[ -z "$INPUT_FILE" ]]; then
  echo "❌ Usage: bash make_resume.sh <markdown-file> [optional-template] [optional-output-dir] [--redacted|-r] [--docx]"
  echo "Examples:"
  echo "  bash make_resume.sh examples/example_resume.md"
  echo "  bash make_resume.sh examples/example_resume.md --docx"
  echo "  bash make_resume.sh examples/example_resume.md templates/modern.latex --redacted"
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

# === Determine output filenames ===
BASE_NAME="$(basename "$INPUT_FILE" .md)"
[[ "$MODE" == "redacted" ]] && BASE_NAME="${BASE_NAME}_redacted"

PDF_OUT="$OUTPUT_DIR/${BASE_NAME}.pdf"
DOCX_OUT="$OUTPUT_DIR/${BASE_NAME}.docx"

# === Redaction step (optional) ===
TEMP_FILE="$INPUT_FILE"
if [[ "$MODE" == "redacted" ]]; then
  echo "🕵️‍♂️ Redacting phone numbers..."
  TEMP_FILE="$(mktemp /tmp/resume_no_phone.XXXXXX.md)"

  # Pattern notes:
  # - Look for a phone token bounded by line start, a pipe, or whitespace
  # - Match +1(234)567-8910, (234)567-8910, 234-567-8910, etc.
  # - Remove one adjacent pipe if it's immediately before *or* after the number
  # - Keep all other text and separators untouched
  sed -E '
    # remove optional space/pipe before the phone
    s/([[:space:]]*\|?[[:space:]]*)(\(?\+?[0-9][0-9() .-]{8,}[0-9]\)?)([[:space:]]*\|?[[:space:]]*)/\1\3/g
    # collapse any accidental double pipes like "| |" -> "|"
    s/\|[[:space:]]*\|/|/g
    # strip a trailing pipe + spaces at end of line
    s/[[:space:]]*\|[[:space:]]*$//g
  ' "$INPUT_FILE" > "$TEMP_FILE"
fi

echo "🔧 Building resume for $INPUT_FILE..."
echo "🧩 Using template: $TEMPLATE"
echo "📁 Output directory: $OUTPUT_DIR"
[[ "$MODE" == "redacted" ]] && echo "✂️  Mode: redacted (phone numbers removed)"
[[ "$BUILD_DOCX" == true ]] && echo "📦 DOCX generation: enabled" || echo "📦 DOCX generation: skipped"

# === Generate PDF ===
echo "📄 Generating PDF..."
if ! pandoc "$TEMP_FILE" \
  --from markdown+raw_tex \
  --template="$TEMPLATE" \
  --pdf-engine=xelatex \
  --output="$PDF_OUT" \
  --metadata=title:"" --metadata=author:""; then
  echo "❌ PDF generation failed."
  exit 1
fi

# === Generate DOCX (optional) ===
if [[ "$BUILD_DOCX" == true ]]; then
  echo "📄 Generating DOCX..."
  if ! pandoc "$TEMP_FILE" \
    --from markdown+raw_tex \
    --to docx \
    --output="$DOCX_OUT" \
    --metadata=title:"" --metadata=author:""; then
    echo "❌ DOCX generation failed."
    exit 1
  fi
fi

# === Cleanup temporary file ===
[[ "$MODE" == "redacted" ]] && rm -f "$TEMP_FILE"

echo "✅ Build complete!"
echo "   PDF:  $PDF_OUT"
if [[ "$BUILD_DOCX" == true ]]; then
  echo "   DOCX: $DOCX_OUT"
fi
