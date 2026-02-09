#!/usr/bin/env bash
#
# manuscript-import.sh — Convert and optionally split documents for Juno import
#
# Usage:
#   manuscript-import.sh <input-file> <output-dir> [options]
#
# Supported input formats: docx, epub, pdf, txt, rtf, odt, html, md
#
# Options:
#   --split                     Split into chapters (auto-detect headings)
#   --split-pattern <regex>     Custom regex for chapter boundaries
#   --prefix <string>           Chapter filename prefix (default: "chapter")
#   --info                      Just report file info, don't convert
#
# Examples:
#   manuscript-import.sh novel.docx my-novel/05-drafts/ --split
#   manuscript-import.sh article.pdf my-blog/05-drafts/
#   manuscript-import.sh memoir.epub my-memoir/05-drafts/ --split --prefix "part"
#   manuscript-import.sh manuscript.txt my-novel/05-drafts/ --split-pattern "^PART [IVXLC]+"
#   manuscript-import.sh novel.docx my-novel/05-drafts/ --info
#

set -euo pipefail

# --- Color output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

info()  { echo -e "${BLUE}[info]${NC} $*"; }
ok()    { echo -e "${GREEN}[done]${NC} $*"; }
warn()  { echo -e "${YELLOW}[warn]${NC} $*"; }
err()   { echo -e "${RED}[error]${NC} $*" >&2; }
stat()  { echo -e "${CYAN}[stat]${NC} $*"; }

# --- Dependency checks ---
check_pandoc() {
  if ! command -v pandoc &>/dev/null; then
    err "Pandoc is not installed. Install with: brew install pandoc"
    exit 1
  fi
}

# --- Usage ---
usage() {
  sed -n '3,22p' "$0" | sed 's/^#//' | sed 's/^ //'
  exit 1
}

# --- Parse arguments ---
INPUT=""
OUTPUT_DIR=""
SPLIT=false
SPLIT_PATTERN=""
PREFIX="chapter"
INFO_ONLY=false

[[ $# -lt 2 ]] && usage

INPUT="$1"; shift
OUTPUT_DIR="$1"; shift

while [[ $# -gt 0 ]]; do
  case "$1" in
    --split)          SPLIT=true; shift ;;
    --split-pattern)  SPLIT=true; SPLIT_PATTERN="$2"; shift 2 ;;
    --prefix)         PREFIX="$2"; shift 2 ;;
    --info)           INFO_ONLY=true; shift ;;
    *) err "Unknown option: $1"; usage ;;
  esac
done

# --- Validate input ---
if [[ ! -f "$INPUT" ]]; then
  err "Input file not found: $INPUT"
  exit 1
fi

INPUT="$(cd "$(dirname "$INPUT")" && pwd)/$(basename "$INPUT")"
EXTENSION="${INPUT##*.}"
EXTENSION_LOWER="$(echo "$EXTENSION" | tr '[:upper:]' '[:lower:]')"
BASENAME="$(basename "$INPUT" ".$EXTENSION")"

# --- Supported formats ---
case "$EXTENSION_LOWER" in
  md|markdown|txt|text|docx|epub|pdf|rtf|odt|html|htm)
    ;; # supported
  *)
    err "Unsupported format: .$EXTENSION_LOWER"
    err "Supported: md, txt, docx, epub, pdf, rtf, odt, html"
    exit 1
    ;;
esac

# --- File info ---
file_word_count() {
  local file="$1"
  local ext="${file##*.}"
  ext="$(echo "$ext" | tr '[:upper:]' '[:lower:]')"

  case "$ext" in
    md|markdown|txt|text)
      wc -w < "$file" | tr -d ' '
      ;;
    docx|epub|rtf|odt|html|htm)
      pandoc "$file" --to plain 2>/dev/null | wc -w | tr -d ' '
      ;;
    pdf)
      pandoc "$file" --to plain 2>/dev/null | wc -w | tr -d ' '
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

print_file_info() {
  local words
  words="$(file_word_count "$INPUT")"

  echo ""
  echo -e "${BLUE}━━━ File Info ━━━${NC}"
  echo "  File:      $(basename "$INPUT")"
  echo "  Format:    $EXTENSION_LOWER"
  echo "  Size:      $(du -h "$INPUT" | cut -f1 | tr -d ' ')"
  echo "  Words:     ~${words}"

  if [[ "$words" != "unknown" ]]; then
    local pages=$(( words / 250 ))
    echo "  Est pages: ~${pages} (at 250 words/page)"

    if [[ "$words" -gt 40000 ]]; then
      echo ""
      warn "This is a large document (~${words} words)."
      info "Recommendation: use --split to break into chapters for better handling."
    fi
  fi
  echo ""
}

# --- Info-only mode ---
if [[ "$INFO_ONLY" == true ]]; then
  check_pandoc
  print_file_info
  exit 0
fi

# --- Ensure output directory ---
mkdir -p "$OUTPUT_DIR"
OUTPUT_DIR="$(cd "$OUTPUT_DIR" && pwd)"

# --- Convert to markdown ---
convert_to_markdown() {
  local output="${OUTPUT_DIR}/${BASENAME}.md"

  case "$EXTENSION_LOWER" in
    md|markdown)
      info "Input is already markdown — copying to output"
      cp "$INPUT" "$output"
      ;;
    txt|text)
      info "Converting plain text to markdown"
      cp "$INPUT" "$output"
      ;;
    *)
      info "Converting $EXTENSION_LOWER to markdown via Pandoc"
      pandoc "$INPUT" \
        --from "$EXTENSION_LOWER" \
        --to markdown \
        --wrap=none \
        --strip-comments \
        --extract-media="${OUTPUT_DIR}/media" \
        -o "$output" 2>/dev/null || {
          # Retry without media extraction if it fails
          pandoc "$INPUT" \
            --from "$EXTENSION_LOWER" \
            --to markdown \
            --wrap=none \
            --strip-comments \
            -o "$output"
        }
      ;;
  esac

  # Clean up pandoc artifacts
  if [[ -f "$output" ]]; then
    # Remove excessive blank lines (more than 2 consecutive)
    local tmp="${output}.tmp"
    awk 'NF{blank=0} !NF{blank++} blank<=2' "$output" > "$tmp" && mv "$tmp" "$output"
  fi

  echo "$output"
}

# --- Chapter splitting ---
split_into_chapters() {
  local source="$1"
  local chapter_num=0
  local current_file=""
  local line_count=0
  local total_chapters=0

  # Default split patterns (tried in order of specificity)
  local patterns=(
    '^# .+'                                          # Markdown H1
    '^## .+'                                         # Markdown H2
    '^Chapter [0-9]+'                                # "Chapter 1", "Chapter 23"
    '^Chapter [A-Z][a-z]+'                           # "Chapter One", "Chapter Twenty"
    '^CHAPTER [0-9]+'                                # "CHAPTER 1"
    '^CHAPTER [A-Z]+'                                # "CHAPTER ONE"
    '^Part [0-9IVXLC]+'                              # "Part 1", "Part IV"
    '^PART [0-9IVXLC]+'                              # "PART 1", "PART IV"
    '^\*[[:space:]]*\*[[:space:]]*\*[[:space:]]*$'   # "* * *" scene breaks (last resort)
  )

  # Use custom pattern if provided
  if [[ -n "$SPLIT_PATTERN" ]]; then
    patterns=("$SPLIT_PATTERN")
  fi

  # Detect which pattern matches
  local chosen_pattern=""
  for pat in "${patterns[@]}"; do
    local matches
    matches=$(grep -cE "$pat" "$source" 2>/dev/null || true)
    if [[ "$matches" -gt 1 ]]; then
      chosen_pattern="$pat"
      info "Detected chapter pattern: $pat ($matches matches)"
      break
    fi
  done

  if [[ -z "$chosen_pattern" ]]; then
    warn "No chapter headings detected. Saving as single file."
    local dest="${OUTPUT_DIR}/${PREFIX}-01.md"
    cp "$source" "$dest"
    ok "Saved: $(basename "$dest")"
    stat "1 file created (no chapter splits found)"
    return
  fi

  # Split the file
  info "Splitting on pattern: $chosen_pattern"

  local in_preamble=true
  local preamble_lines=()

  while IFS= read -r line || [[ -n "$line" ]]; do
    if echo "$line" | grep -qE "$chosen_pattern"; then
      # Close previous chapter file
      if [[ -n "$current_file" ]] && [[ "$line_count" -gt 0 ]]; then
        total_chapters=$((total_chapters + 1))
      fi

      # Start new chapter
      chapter_num=$((chapter_num + 1))
      current_file="${OUTPUT_DIR}/${PREFIX}-$(printf '%02d' "$chapter_num").md"
      line_count=0
      in_preamble=false

      # Write the heading line
      echo "$line" > "$current_file"
      line_count=$((line_count + 1))
    elif [[ "$in_preamble" == true ]]; then
      # Collect preamble (content before first chapter heading)
      preamble_lines+=("$line")
    elif [[ -n "$current_file" ]]; then
      echo "$line" >> "$current_file"
      line_count=$((line_count + 1))
    fi
  done < "$source"

  # Count last chapter
  if [[ -n "$current_file" ]] && [[ "$line_count" -gt 0 ]]; then
    total_chapters=$((total_chapters + 1))
  fi

  # Save preamble if it has substantial content
  if [[ ${#preamble_lines[@]} -gt 0 ]]; then
    local preamble_text
    preamble_text="$(printf '%s\n' "${preamble_lines[@]}")"
    local preamble_words
    preamble_words="$(echo "$preamble_text" | wc -w | tr -d ' ')"

    if [[ "$preamble_words" -gt 20 ]]; then
      local preamble_file="${OUTPUT_DIR}/front-matter.md"
      printf '%s\n' "${preamble_lines[@]}" > "$preamble_file"
      info "Saved front matter ($preamble_words words): $(basename "$preamble_file")"
    fi
  fi

  # Report results
  echo ""
  stat "Split into $chapter_num files:"
  for f in "${OUTPUT_DIR}/${PREFIX}"-*.md; do
    if [[ -f "$f" ]]; then
      local w
      w="$(wc -w < "$f" | tr -d ' ')"
      ok "  $(basename "$f") — ~${w} words"
    fi
  done

  # Remove the single-file conversion (we have chapters now)
  if [[ -f "${OUTPUT_DIR}/${BASENAME}.md" ]]; then
    rm "${OUTPUT_DIR}/${BASENAME}.md"
  fi
}

# --- Main ---
check_pandoc

echo ""
echo -e "${BLUE}━━━ Manuscript Import ━━━${NC}"
echo "  Input:   $(basename "$INPUT")"
echo "  Format:  $EXTENSION_LOWER"
echo "  Output:  $OUTPUT_DIR"
echo "  Split:   $SPLIT"
echo ""

# Print info
print_file_info

# Convert
info "Starting conversion..."
CONVERTED="$(convert_to_markdown)"
ok "Converted to markdown: $(basename "$CONVERTED")"

# Word count of converted file
TOTAL_WORDS="$(wc -w < "$CONVERTED" | tr -d ' ')"
stat "Total words: ~${TOTAL_WORDS}"

# Split if requested
if [[ "$SPLIT" == true ]]; then
  echo ""
  info "Splitting into chapters..."
  split_into_chapters "$CONVERTED"
fi

echo ""
echo -e "${GREEN}━━━ Import complete ━━━${NC}"
