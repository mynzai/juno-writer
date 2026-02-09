#!/usr/bin/env bash
#
# manuscript-export.sh — Convert compiled manuscript markdown to docx, epub, or pdf
#
# Usage:
#   manuscript-export.sh <input.md> <format> [options]
#
# Formats: docx, epub, pdf, all
#
# Options:
#   --title "Book Title"        Set the title (otherwise extracted from metadata/filename)
#   --author "Author Name"      Set the author
#   --output-dir <path>         Output directory (default: same as input file)
#   --toc                       Include table of contents
#   --cover <image-path>        Cover image (epub/pdf only)
#   --stylesheet <css-path>     Custom CSS (epub/pdf only)
#   --no-default-style          Skip the bundled epub/pdf stylesheet
#
# Examples:
#   manuscript-export.sh my-novel/manuscript-2026-02-09.md docx --title "My Novel" --author "Jane Doe"
#   manuscript-export.sh manuscript.md epub --cover cover.jpg --toc
#   manuscript-export.sh manuscript.md all --title "My Novel" --author "Jane Doe" --toc
#   manuscript-export.sh manuscript.md pdf

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_EPUB_CSS="${SCRIPT_DIR}/epub-stylesheet.css"
DEFAULT_PDF_CSS="${SCRIPT_DIR}/pdf-stylesheet.css"

# --- Color output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[info]${NC} $*"; }
ok()    { echo -e "${GREEN}[done]${NC} $*"; }
warn()  { echo -e "${YELLOW}[warn]${NC} $*"; }
err()   { echo -e "${RED}[error]${NC} $*" >&2; }

# --- Dependency checks ---
check_pandoc() {
  if ! command -v pandoc &>/dev/null; then
    err "Pandoc is not installed. Install with: brew install pandoc"
    exit 1
  fi
}

check_pdf_engine() {
  if command -v weasyprint &>/dev/null; then
    echo "weasyprint"
  elif command -v wkhtmltopdf &>/dev/null; then
    echo "wkhtmltopdf"
  elif command -v xelatex &>/dev/null; then
    echo "xelatex"
  elif command -v pdflatex &>/dev/null; then
    echo "pdflatex"
  else
    echo ""
  fi
}

# --- Usage ---
usage() {
  sed -n '3,27p' "$0" | sed 's/^#//' | sed 's/^ //'
  exit 1
}

# --- Parse arguments ---
INPUT=""
FORMAT=""
TITLE=""
AUTHOR=""
OUTPUT_DIR=""
TOC=false
COVER=""
STYLESHEET=""
NO_DEFAULT_STYLE=false

[[ $# -lt 2 ]] && usage

INPUT="$1"; shift
FORMAT="$1"; shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title)       TITLE="$2"; shift 2 ;;
    --author)      AUTHOR="$2"; shift 2 ;;
    --output-dir)  OUTPUT_DIR="$2"; shift 2 ;;
    --toc)         TOC=true; shift ;;
    --cover)       COVER="$2"; shift 2 ;;
    --stylesheet)  STYLESHEET="$2"; shift 2 ;;
    --no-default-style) NO_DEFAULT_STYLE=true; shift ;;
    *) err "Unknown option: $1"; usage ;;
  esac
done

# --- Validate input ---
if [[ ! -f "$INPUT" ]]; then
  err "Input file not found: $INPUT"
  exit 1
fi

INPUT="$(cd "$(dirname "$INPUT")" && pwd)/$(basename "$INPUT")"
BASENAME="$(basename "$INPUT" .md)"

if [[ -z "$OUTPUT_DIR" ]]; then
  OUTPUT_DIR="$(dirname "$INPUT")"
fi
mkdir -p "$OUTPUT_DIR"

# --- Extract metadata from YAML front matter if present ---
extract_meta() {
  local key="$1"
  # Look for YAML front matter between --- delimiters
  if head -1 "$INPUT" | grep -q '^---$'; then
    local val
    val="$(sed -n '2,/^---$/p' "$INPUT" | grep "^${key}:" | sed "s/^${key}:[[:space:]]*//" | head -1)"
    # Strip surrounding quotes if present
    val="${val#\"}"
    val="${val%\"}"
    val="${val#\'}"
    val="${val%\'}"
    echo "$val"
  fi
}

if [[ -z "$TITLE" ]]; then
  TITLE="$(extract_meta title)"
  if [[ -z "$TITLE" ]]; then
    # Fall back to filename, cleaned up
    TITLE="$(echo "$BASENAME" | sed 's/manuscript-[0-9-]*//' | sed 's/-/ /g' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')"
    [[ -z "$TITLE" ]] && TITLE="$BASENAME"
  fi
fi

if [[ -z "$AUTHOR" ]]; then
  AUTHOR="$(extract_meta author)"
fi

# --- Build Pandoc base args into PANDOC_ARGS global array ---
build_base_args() {
  PANDOC_ARGS=()
  PANDOC_ARGS+=(--from markdown)
  PANDOC_ARGS+=(--standalone)
  PANDOC_ARGS+=(--top-level-division=chapter)

  # Metadata
  [[ -n "$TITLE" ]]  && PANDOC_ARGS+=(--metadata "title=${TITLE}")
  [[ -n "$AUTHOR" ]] && PANDOC_ARGS+=(--metadata "author=${AUTHOR}")
  PANDOC_ARGS+=(--metadata "date=$(date +%Y-%m-%d)")
  PANDOC_ARGS+=(--metadata "lang=en-US")

  # Table of contents
  [[ "$TOC" == true ]] && PANDOC_ARGS+=(--toc --toc-depth=2)
}

# --- Export functions ---
export_docx() {
  local output="${OUTPUT_DIR}/${BASENAME}.docx"
  build_base_args

  info "Generating DOCX: $(basename "$output")"
  pandoc "$INPUT" "${PANDOC_ARGS[@]}" -o "$output"
  ok "DOCX saved: $output"
  echo "   $(wc -c < "$output" | tr -d ' ') bytes"
}

export_epub() {
  local output="${OUTPUT_DIR}/${BASENAME}.epub"
  build_base_args

  # Stylesheet
  if [[ -n "$STYLESHEET" ]]; then
    PANDOC_ARGS+=(--css "$STYLESHEET")
  elif [[ "$NO_DEFAULT_STYLE" != true ]] && [[ -f "$DEFAULT_EPUB_CSS" ]]; then
    PANDOC_ARGS+=(--css "$DEFAULT_EPUB_CSS")
  fi

  # Cover image
  [[ -n "$COVER" ]] && PANDOC_ARGS+=(--epub-cover-image "$COVER")

  info "Generating EPUB: $(basename "$output")"
  pandoc "$INPUT" "${PANDOC_ARGS[@]}" -o "$output"
  ok "EPUB saved: $output"
  echo "   $(wc -c < "$output" | tr -d ' ') bytes"
}

export_pdf() {
  local output="${OUTPUT_DIR}/${BASENAME}.pdf"
  local engine
  engine="$(check_pdf_engine)"

  if [[ -z "$engine" ]]; then
    err "No PDF engine found. Install one of:"
    err "  brew install weasyprint     (recommended, lightweight)"
    err "  brew install --cask mactex  (full LaTeX, large download)"
    return 1
  fi

  build_base_args
  PANDOC_ARGS+=(--pdf-engine="$engine")

  # For weasyprint/wkhtmltopdf, apply CSS
  if [[ "$engine" == "weasyprint" || "$engine" == "wkhtmltopdf" ]]; then
    if [[ -n "$STYLESHEET" ]]; then
      PANDOC_ARGS+=(--css "$STYLESHEET")
    elif [[ "$NO_DEFAULT_STYLE" != true ]] && [[ -f "$DEFAULT_PDF_CSS" ]]; then
      PANDOC_ARGS+=(--css "$DEFAULT_PDF_CSS")
    fi
  fi

  info "Generating PDF (engine: $engine): $(basename "$output")"
  pandoc "$INPUT" "${PANDOC_ARGS[@]}" -o "$output"
  ok "PDF saved: $output"
  echo "   $(wc -c < "$output" | tr -d ' ') bytes"
}

# --- Main ---
check_pandoc

echo ""
echo -e "${BLUE}━━━ Manuscript Export ━━━${NC}"
echo "  Input:  $(basename "$INPUT")"
echo "  Title:  ${TITLE:-"(none)"}"
echo "  Author: ${AUTHOR:-"(none)"}"
echo ""

case "$FORMAT" in
  docx) export_docx ;;
  epub) export_epub ;;
  pdf)  export_pdf ;;
  all)
    export_docx
    echo ""
    export_epub
    echo ""
    export_pdf
    ;;
  *)
    err "Unknown format: $FORMAT"
    err "Supported: docx, epub, pdf, all"
    exit 1
    ;;
esac

echo ""
echo -e "${GREEN}━━━ Export complete ━━━${NC}"
