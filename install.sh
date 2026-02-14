#!/bin/bash
set -e

# Juno Creative Writing Orchestrator — Installer
# Usage: ./install.sh [destination]
# Or:    curl -fsSL https://raw.githubusercontent.com/mynzai/juno-writer/main/install.sh | bash

REPO="mynzai/juno-writer"
BRANCH="main"
DEFAULT_DEST="$HOME/creative-writing"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

print_step() { echo -e "${CYAN}[*]${NC} $1"; }
print_ok()   { echo -e "${GREEN}[+]${NC} $1"; }
print_warn() { echo -e "${YELLOW}[!]${NC} $1"; }
print_err()  { echo -e "${RED}[x]${NC} $1"; }

echo ""
echo -e "${CYAN}  ╔═══════════════════════════════════════╗${NC}"
echo -e "${CYAN}  ║   Juno — Creative Writing Orchestrator ║${NC}"
echo -e "${CYAN}  ║            Installer v1.0              ║${NC}"
echo -e "${CYAN}  ╚═══════════════════════════════════════╝${NC}"
echo ""

# Determine destination
DEST="${1:-$DEFAULT_DEST}"

# Expand ~ if present
DEST="${DEST/#\~/$HOME}"

# Check for Claude Code
if command -v claude &> /dev/null; then
    print_ok "Claude Code found: $(claude --version 2>/dev/null || echo 'installed')"
else
    print_warn "Claude Code not found. Juno requires Claude Code to run."
    echo "  Install it with: npm install -g @anthropic-ai/claude-code"
    echo ""
    read -p "Continue anyway? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Installation cancelled."
        exit 1
    fi
fi

# Check if destination exists and has Juno already
if [ -d "$DEST/_bmad/custom/agents/juno" ]; then
    print_warn "Existing Juno installation found at $DEST"
    echo ""
    echo "  Options:"
    echo "    1) Update — Replace agent files, keep your memory and projects"
    echo "    2) Fresh  — Remove everything and start clean"
    echo "    3) Cancel — Exit without changes"
    echo ""
    read -p "  Choose [1/2/3]: " -n 1 -r
    echo
    case $REPLY in
        1)
            MODE="update"
            print_step "Updating Juno (preserving memory and projects)..."
            ;;
        2)
            MODE="fresh"
            print_warn "This will delete all Juno data at $DEST/_bmad"
            read -p "  Are you sure? [y/N] " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "Installation cancelled."
                exit 1
            fi
            rm -rf "$DEST/_bmad"
            rm -f "$DEST/.claude/commands/juno.md"
            rm -f "$DEST/CLAUDE.md"
            print_step "Clean slate. Installing fresh..."
            ;;
        *)
            echo "Installation cancelled."
            exit 0
            ;;
    esac
else
    MODE="install"
    print_step "Installing Juno to $DEST ..."
fi

# Create temp directory for download
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

# Download the repo
print_step "Downloading Juno from GitHub..."
if command -v git &> /dev/null; then
    git clone --depth 1 --branch "$BRANCH" "https://github.com/$REPO.git" "$TMPDIR/juno-writer" 2>/dev/null
    SRC="$TMPDIR/juno-writer"
elif command -v curl &> /dev/null; then
    curl -fsSL "https://github.com/$REPO/archive/refs/heads/$BRANCH.tar.gz" -o "$TMPDIR/juno.tar.gz"
    tar -xzf "$TMPDIR/juno.tar.gz" -C "$TMPDIR"
    SRC="$TMPDIR/juno-writer-$BRANCH"
else
    print_err "Neither git nor curl found. Please install one and try again."
    exit 1
fi

print_ok "Downloaded successfully."

# Create destination directory
mkdir -p "$DEST"

# Install slash commands
mkdir -p "$DEST/.claude/commands"
cp "$SRC/.claude/commands/juno.md" "$DEST/.claude/commands/"
cp "$SRC/.claude/commands/masque.md" "$DEST/.claude/commands/"
cp "$SRC/.claude/commands/loom.md" "$DEST/.claude/commands/"
print_ok "Slash commands installed (/juno, /masque, /loom)"

# Install project settings (permissions for WebSearch/WebFetch)
if [ -f "$SRC/.claude/settings.json" ]; then
    cp "$SRC/.claude/settings.json" "$DEST/.claude/"
    print_ok "Project settings installed"
fi

# Install agent definition
mkdir -p "$DEST/_bmad/custom/agents/juno"
cp "$SRC/_bmad/custom/agents/juno/juno.agent.yaml" "$DEST/_bmad/custom/agents/juno/"
cp "$SRC/_bmad/custom/agents/juno/JUNO-USER-GUIDE.md" "$DEST/_bmad/custom/agents/juno/"
cp "$SRC/_bmad/custom/agents/juno/JUNO-INSTALLATION-GUIDE.md" "$DEST/_bmad/custom/agents/juno/"
cp "$SRC/_bmad/custom/module.yaml" "$DEST/_bmad/custom/"
print_ok "Agent definition installed"

# Install sub-agents
mkdir -p "$DEST/_bmad/custom/agents/juno/sub-agents"
cp "$SRC/_bmad/custom/agents/juno/sub-agents/"*.yaml "$DEST/_bmad/custom/agents/juno/sub-agents/"
print_ok "Sub-agents installed (raven, thistle, lynx, masque, loom, vestry, wraith)"

# Install tools
if [ -d "$SRC/_bmad/custom/agents/juno/tools" ]; then
    mkdir -p "$DEST/_bmad/custom/agents/juno/tools"
    cp "$SRC/_bmad/custom/agents/juno/tools/"* "$DEST/_bmad/custom/agents/juno/tools/"
    chmod +x "$DEST/_bmad/custom/agents/juno/tools/"*.sh 2>/dev/null || true
    print_ok "Tools installed (import/export scripts, stylesheets)"
fi

# Install sidecar memory (only if not updating, to preserve existing memory)
if [ "$MODE" != "update" ]; then
    mkdir -p "$DEST/_bmad/_memory/juno-sidecar/voice-profiles"
    mkdir -p "$DEST/_bmad/_memory/juno-sidecar/directive-templates"
    cp "$SRC/_bmad/_memory/juno-sidecar/project-memory.md" "$DEST/_bmad/_memory/juno-sidecar/"
    cp "$SRC/_bmad/_memory/juno-sidecar/projects-registry.md" "$DEST/_bmad/_memory/juno-sidecar/"
    cp "$SRC/_bmad/_memory/juno-sidecar/active-voice-profile.md" "$DEST/_bmad/_memory/juno-sidecar/"
    cp "$SRC/_bmad/_memory/juno-sidecar/instructions.md" "$DEST/_bmad/_memory/juno-sidecar/"
    cp "$SRC/_bmad/_memory/juno-sidecar/writing-directives.md" "$DEST/_bmad/_memory/juno-sidecar/"
    cp "$SRC/_bmad/_memory/juno-sidecar/README.md" "$DEST/_bmad/_memory/juno-sidecar/"
    cp "$SRC/_bmad/_memory/juno-sidecar/voice-profiles/default.md" "$DEST/_bmad/_memory/juno-sidecar/voice-profiles/"
    cp "$SRC/_bmad/_memory/juno-sidecar/directive-templates/"*.md "$DEST/_bmad/_memory/juno-sidecar/directive-templates/"
    print_ok "Memory sidecar installed (with directive templates)"
else
    # Always update directive templates even in update mode (they're system files, not user data)
    mkdir -p "$DEST/_bmad/_memory/juno-sidecar/directive-templates"
    cp "$SRC/_bmad/_memory/juno-sidecar/directive-templates/"*.md "$DEST/_bmad/_memory/juno-sidecar/directive-templates/"
    print_ok "Memory sidecar preserved (update mode) — directive templates refreshed"
fi

# Install CLAUDE.md (only if not present, to avoid overwriting user customizations)
if [ ! -f "$DEST/CLAUDE.md" ]; then
    cp "$SRC/CLAUDE.md" "$DEST/"
    print_ok "CLAUDE.md installed"
else
    print_ok "CLAUDE.md already exists (preserved)"
fi

# Set permissions
chmod -R u+rw "$DEST/_bmad"
chmod -R u+rw "$DEST/.claude"

echo ""
echo -e "${GREEN}  ╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}  ║       Installation complete!           ║${NC}"
echo -e "${GREEN}  ╚═══════════════════════════════════════╝${NC}"
echo ""
echo "  Installed to: $DEST"
echo ""
echo "  To get started:"
echo -e "    ${CYAN}cd $DEST${NC}"
echo -e "    ${CYAN}claude${NC}"
echo -e "    ${CYAN}/juno${NC}"
echo ""
echo "  Documentation: $DEST/_bmad/custom/agents/juno/JUNO-USER-GUIDE.md"
echo ""
