# Juno Installation Guide

How to install Juno, the Creative Writing Orchestrator, on any computer.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [What You Need to Copy](#what-you-need-to-copy)
3. [Installation Steps](#installation-steps)
4. [Directory Structure](#directory-structure)
5. [Verification](#verification)
6. [Troubleshooting](#troubleshooting)
7. [Updating Juno](#updating-juno)

---

## Prerequisites

### Required

| Requirement | Description |
|-------------|-------------|
| **Claude Code** | Anthropic's CLI tool for Claude. Juno runs as a slash command within Claude Code. |
| **Terminal access** | macOS Terminal, Windows PowerShell/CMD, or Linux shell |
| **File system access** | Ability to create folders and copy files |

### Installing Claude Code

If you don't have Claude Code installed:

**macOS / Linux:**
```bash
npm install -g @anthropic-ai/claude-code
```

**Or via Homebrew (macOS):**
```bash
brew install claude-code
```

**Windows:**
```powershell
npm install -g @anthropic-ai/claude-code
```

**Verify installation:**
```bash
claude --version
```

### Optional but Recommended

| Tool | Purpose | Install |
|------|---------|---------|
| **Pandoc** | Required for `[IM]` Import and `[EX]` Export (format conversion) | `brew install pandoc` |
| **WeasyPrint** | Required only for PDF export | `brew install weasyprint` |
| **Git** | Version control for your writing projects | `brew install git` |
| **VS Code** | IDE with Claude Code extension for visual editing | [code.visualstudio.com](https://code.visualstudio.com) |

---

## What You Need to Copy

Juno consists of three components that must be installed together:

### 1. Project Configuration (Required)

```
CLAUDE.md                          # Project instructions for Claude Code
.claude/commands/juno.md           # Slash command — enables /juno
```

### 2. Agent Definition (Required)

```
_bmad/custom/agents/juno/
├── juno.agent.yaml                # Core agent definition (41 commands, 28 prompts)
├── JUNO-USER-GUIDE.md             # User documentation
├── JUNO-INSTALLATION-GUIDE.md     # This file
└── tools/
    ├── manuscript-import.sh       # Import & format conversion script
    ├── manuscript-export.sh       # Export & compilation script
    ├── epub-stylesheet.css        # EPUB typography styles
    └── pdf-stylesheet.css         # PDF print layout styles
```

Plus the module configuration:
```
_bmad/custom/module.yaml
```

### 3. Sidecar Memory (Required)

```
_bmad/_memory/juno-sidecar/
├── project-memory.md              # Active project context
├── projects-registry.md           # All projects tracker
├── active-voice-profile.md        # Current writing voice
├── instructions.md                # User preferences
├── writing-directives.md          # Global writing rules Juno follows
├── README.md                      # Sidecar documentation
└── voice-profiles/
    └── default.md                 # Default voice profile
```

---

## Installation Steps

### Step 1: Create Your Creative Writing Directory

Choose where you want your creative writing workspace:

```bash
mkdir -p ~/creative-writing
cd ~/creative-writing
```

This will be your **project root** — all writing projects live here.

### Step 2: Copy the BMAD Framework

Copy the entire `_bmad` folder to your creative writing directory:

```bash
# From the source machine, copy _bmad folder
cp -r /path/to/source/_bmad ~/creative-writing/
```

**Resulting structure:**
```
~/creative-writing/
└── _bmad/
    ├── custom/
    │   ├── module.yaml
    │   └── agents/juno/
    │       ├── juno.agent.yaml
    │       ├── JUNO-USER-GUIDE.md
    │       ├── JUNO-INSTALLATION-GUIDE.md
    │       └── tools/
    │           ├── manuscript-import.sh
    │           ├── manuscript-export.sh
    │           ├── epub-stylesheet.css
    │           └── pdf-stylesheet.css
    └── _memory/juno-sidecar/
        ├── project-memory.md
        ├── projects-registry.md
        ├── active-voice-profile.md
        ├── instructions.md
        ├── writing-directives.md
        ├── README.md
        └── voice-profiles/
            └── default.md
```

### Step 3: Install the Slash Command and Project Config

The slash command and CLAUDE.md must be placed in your creative writing directory:

**Option A: Project-level (recommended)**

Install in your creative writing directory so it's available when you're in that folder:

```bash
# Slash command
mkdir -p ~/creative-writing/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/creative-writing/.claude/commands/

# Project config
cp /path/to/source/CLAUDE.md ~/creative-writing/
```

**Option B: Global slash command**

Install the slash command in your home directory so it's available everywhere (CLAUDE.md should still go in the project directory):

```bash
mkdir -p ~/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/.claude/commands/
cp /path/to/source/CLAUDE.md ~/creative-writing/
```

### Step 4: Reset Memory Files (Fresh Start)

If you want a clean slate (no previous project history), reset the memory files:

**project-memory.md** should contain:
```markdown
# Project Memory

## Active Project

**Project:** (none yet)
**Path:** —
**Phase:** —
**Last Session:** —

---

## Quick Context

**Current Focus:** —
**Open Threads:** —
**Pending Decisions:** —

---

## Session History

---

## Milestones

---

## Notes

---

## See Also

- **All projects:** See `projects-registry.md` for full project list
- **Switch projects:** Use `[LP]` to list and switch
```

**projects-registry.md** should contain:
```markdown
# Projects Registry

Juno tracks all creative writing projects here.

## Active Project

**Name:** (none)
**Path:** —
**Phase:** —
**Last Session:** —

---

## All Projects

| Project | Path | Phase | Last Touched |
|---------|------|-------|--------------|
| — | — | — | — |

---

## Usage

- **Create new:** Use `[GS] Genesis` or `[NP] New Project`
- **Switch:** Use `[LP] List Projects` then select by number
- **Register existing:** Use `[RP] Register Project` and provide path

---

## Notes

Projects are stored in subfolders under the working directory.
```

### Step 5: Verify File Permissions

Ensure all files are readable and scripts are executable:

```bash
chmod -R u+rw ~/creative-writing/_bmad
chmod -R u+rw ~/creative-writing/.claude
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh
```

---

## Directory Structure

After installation, your creative writing workspace should look like this:

```
~/creative-writing/                    # Your project root
├── CLAUDE.md                          # Project instructions for Claude Code
├── .claude/
│   └── commands/
│       └── juno.md                    # Slash command
├── _bmad/
│   ├── custom/
│   │   ├── module.yaml                # Module config
│   │   └── agents/juno/
│   │       ├── juno.agent.yaml        # Agent definition
│   │       ├── JUNO-USER-GUIDE.md     # Documentation
│   │       ├── JUNO-INSTALLATION-GUIDE.md
│   │       └── tools/
│   │           ├── manuscript-import.sh   # Import script
│   │           ├── manuscript-export.sh   # Export script
│   │           ├── epub-stylesheet.css    # EPUB styles
│   │           └── pdf-stylesheet.css     # PDF styles
│   └── _memory/juno-sidecar/
│       ├── project-memory.md          # Session memory
│       ├── projects-registry.md       # Project list
│       ├── active-voice-profile.md    # Voice settings
│       ├── instructions.md            # Preferences
│       ├── writing-directives.md      # Global writing rules
│       └── voice-profiles/
│           └── default.md             # Default voice
│
├── my-novel/                          # Example project (created by Juno)
│   ├── 00-genesis/
│   ├── 01-world/
│   └── ...
│
└── blog-posts/                        # Another project
    ├── 00-genesis/
    └── ...
```

---

## Verification

### Test 1: Check Slash Command

```bash
cd ~/creative-writing
claude
```

Then type:
```
/juno
```

Juno should greet you and ask if you're continuing an existing project or starting new.

### Test 2: Check Memory Loading

When Juno activates, she should:
1. Load memory files without errors
2. Show no active project (if fresh install)
3. Offer options: existing project or new project

### Test 3: Create a Test Project

1. Invoke `/juno`
2. Choose "Start a new project"
3. Select "Blog Post" (quickest to scaffold)
4. Follow prompts to create a test project
5. Verify folder structure was created

### Test 4: Verify Project Switching

1. Invoke `/juno`
2. Use `[LP]` to list projects
3. Your test project should appear
4. Switch to it and verify context loads

---

## Troubleshooting

### "Command not found: /juno"

**Cause:** Slash command file not in correct location

**Fix:**
```bash
# Check if file exists
ls -la ~/creative-writing/.claude/commands/juno.md

# If missing, copy it
mkdir -p ~/creative-writing/.claude/commands
# Copy from source
```

### "Cannot load memory files"

**Cause:** Sidecar folder missing or incorrect path

**Fix:**
```bash
# Verify sidecar exists
ls -la ~/creative-writing/_bmad/_memory/juno-sidecar/

# Should see: project-memory.md, projects-registry.md, etc.
```

### Juno doesn't remember previous sessions

**Cause:** Memory files not being written/read correctly

**Fix:**
1. Check file permissions: `chmod u+rw ~/creative-writing/_bmad/_memory/juno-sidecar/*`
2. Verify you're in the correct directory when invoking `/juno`
3. Check that `project-memory.md` is being updated after sessions

### Projects not showing in registry

**Cause:** Projects created but not registered

**Fix:**
1. Use `[OP]` Open command to open the project folder
2. Juno will register it in `projects-registry.md`
3. Or manually add to the registry table

### Wrong directory structure created

**Cause:** Genre not detected or wrong genre selected

**Fix:**
1. Delete the project folder
2. Restart Genesis with `/juno`
3. Select the correct genre when prompted

---

## Updating Juno

When updates are available:

### Full Update (Recommended)

Replace all Juno files while preserving your memory:

```bash
# Backup your memory
cp -r ~/creative-writing/_bmad/_memory/juno-sidecar ~/juno-sidecar-backup

# Copy new agent files (not memory)
cp /path/to/new/_bmad/custom/agents/juno/*.yaml ~/creative-writing/_bmad/custom/agents/juno/
cp /path/to/new/_bmad/custom/agents/juno/*.md ~/creative-writing/_bmad/custom/agents/juno/
cp -r /path/to/new/_bmad/custom/agents/juno/tools/ ~/creative-writing/_bmad/custom/agents/juno/

# Copy updated slash command and project config
cp /path/to/new/.claude/commands/juno.md ~/creative-writing/.claude/commands/
cp /path/to/new/CLAUDE.md ~/creative-writing/

# Ensure scripts are executable
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh

# Your memory is preserved in place
```

### Migrating Memory Templates

If you are updating from a version with fewer commands (23 commands) to the current version (41 commands), your `project-memory.md` template may be missing new tracking sections. To add them manually, append these sections after "Quick Context" in your existing `project-memory.md`:

- **Word Count Tracking** — target, current total, daily goal, session log table
- **Subplot Tracking** — thread status table (populated by `[SB]`)
- **Theme & Motif Tracking** — element tracking table (populated by `[TH]`)
- **Foreshadowing Ledger** — setup/payoff status table (populated by `[FL]`)

See the fresh `project-memory.md` template for the exact format. Your `instructions.md` also has new preference sections for session management and genre defaults.

**Note:** The agent YAML (`juno.agent.yaml`) has grown significantly to support 41 commands with 28 detailed prompts. This is expected and does not affect performance since prompts are loaded on demand.

### Partial Update (Agent Only)

If only the agent definition changed:

```bash
cp /path/to/new/_bmad/custom/agents/juno/juno.agent.yaml \
   ~/creative-writing/_bmad/custom/agents/juno/
```

### Fresh Install (Reset Everything)

If you want to start completely fresh:

```bash
# Remove old installation
rm -rf ~/creative-writing/_bmad
rm -rf ~/creative-writing/.claude/commands/juno.md
rm -f ~/creative-writing/CLAUDE.md

# Copy everything new
cp -r /path/to/new/_bmad ~/creative-writing/
cp -r /path/to/new/.claude ~/creative-writing/
cp /path/to/new/CLAUDE.md ~/creative-writing/
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh
```

---

## Quick Install Script

For automated installation, save this as `install-juno.sh`:

```bash
#!/bin/bash

# Juno Installation Script
# Usage: ./install-juno.sh /path/to/source /path/to/destination

SOURCE="${1:-./}"
DEST="${2:-~/creative-writing}"

echo "Installing Juno to $DEST..."

# Check for Pandoc (recommended)
if ! command -v pandoc &>/dev/null; then
  echo "Note: Pandoc not found. Install with 'brew install pandoc' for Import/Export features."
fi

# Create destination
mkdir -p "$DEST"

# Copy BMAD framework
mkdir -p "$DEST/_bmad"
cp -r "$SOURCE/_bmad/custom" "$DEST/_bmad/"
cp -r "$SOURCE/_bmad/_memory" "$DEST/_bmad/"

# Copy slash command
mkdir -p "$DEST/.claude/commands"
cp "$SOURCE/.claude/commands/juno.md" "$DEST/.claude/commands/"

# Copy project config
cp "$SOURCE/CLAUDE.md" "$DEST/"

# Set permissions
chmod -R u+rw "$DEST/_bmad"
chmod -R u+rw "$DEST/.claude"
chmod +x "$DEST/_bmad/custom/agents/juno/tools/"*.sh

echo "Installation complete!"
echo ""
echo "To verify, run:"
echo "  cd $DEST"
echo "  claude"
echo "  /juno"
```

Make it executable:
```bash
chmod +x install-juno.sh
```

Run it:
```bash
./install-juno.sh /path/to/source ~/creative-writing
```

---

## Support

- **User Guide:** See `JUNO-USER-GUIDE.md` for usage instructions
- **Agent Definition:** See `juno.agent.yaml` for technical details
- **Issues:** Check troubleshooting section above

---

*Juno travels with you. Install once, write anywhere.*
