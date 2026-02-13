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
.claude/settings.json              # Project permissions (WebSearch, WebFetch for sub-agents)
```

### 2. Agent Definition (Required)

```
_bmad/custom/agents/juno/
├── juno.agent.yaml                # Core agent definition (50 commands, 32 prompts)
├── JUNO-USER-GUIDE.md             # User documentation
├── JUNO-INSTALLATION-GUIDE.md     # This file
├── sub-agents/                    # Specialist sub-agents Juno can summon
│   ├── raven.agent.yaml           # Research Agent
│   ├── thistle.agent.yaml         # Line Editor
│   ├── lynx.agent.yaml            # Continuity Checker
│   ├── masque.agent.yaml          # Character Voice
│   ├── loom.agent.yaml            # Lore & World Builder
│   └── vestry.agent.yaml          # Knowledge Curator
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
├── project-memory.md              # Live State + active project context
├── projects-registry.md           # All projects tracker
├── active-voice-profile.md        # Current writing voice
├── instructions.md                # User preferences + context management
├── writing-directives.md          # Global writing rules Juno follows
├── session-archive.md             # Past session history (not loaded on startup)
├── README.md                      # Sidecar documentation
├── directive-templates/           # Pre-built writing directive templates
│   ├── starter-pack.md
│   ├── literary-fiction.md
│   ├── genre-thriller.md
│   └── nonfiction-blog.md
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
    │       ├── sub-agents/
    │       │   ├── raven.agent.yaml
    │       │   ├── thistle.agent.yaml
    │       │   ├── lynx.agent.yaml
    │       │   ├── masque.agent.yaml
    │       │   ├── loom.agent.yaml
    │       │   └── vestry.agent.yaml
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
        ├── session-archive.md
        ├── README.md
        ├── directive-templates/
        │   ├── starter-pack.md
        │   ├── literary-fiction.md
        │   ├── genre-thriller.md
        │   └── nonfiction-blog.md
        └── voice-profiles/
            └── default.md
```

### Step 3: Install the Slash Command, Project Config, and Permissions

The slash command, CLAUDE.md, and project settings must be placed in your creative writing directory:

**Option A: Project-level (recommended)**

Install in your creative writing directory so it's available when you're in that folder:

```bash
# Slash command
mkdir -p ~/creative-writing/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/creative-writing/.claude/commands/

# Project config
cp /path/to/source/CLAUDE.md ~/creative-writing/

# Project permissions (enables WebSearch/WebFetch for sub-agents like Raven)
cp /path/to/source/.claude/settings.json ~/creative-writing/.claude/
```

**Option B: Global slash command**

Install the slash command in your home directory so it's available everywhere (CLAUDE.md and settings should still go in the project directory):

```bash
mkdir -p ~/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/.claude/commands/
cp /path/to/source/CLAUDE.md ~/creative-writing/
cp /path/to/source/.claude/settings.json ~/creative-writing/.claude/
```

### Step 4: Reset Memory Files (Fresh Start)

If you want a clean slate (no previous project history), reset the memory files:

**project-memory.md** should contain:
```markdown
# Project Memory

## Live State
<!-- UPDATED: — | STATUS: idle | CMD: — -->

**Session:** — | **Tasks this session:** 0
**Current task:** idle
**Last completed:** —
**Files touched this session:** —
**Words this session:** +0 (total: 0)
**Decisions:**
- (none)
**Open threads:**
- (none)
**Pickup point:** No active project. Use [GS] Genesis to start or [LP] to list existing projects.

---

## Active Project

**Project:** (none yet)
**Path:** —
**Phase:** —
**Genre:** —
**Last Session:** —

---

## Word Count

**Target:** —
**Current Total:** 0
**Next Milestone:** —

---

## Story Tracking

### Subplots
(none yet)

### Themes & Motifs
(none yet)

### Foreshadowing
(none yet)

---

## Milestones

---

## Notes

---

## Previous Session Summary
<!-- Only the LAST session's compact recap lives here. Older sessions in session-archive.md -->

(no sessions yet)

---

## See Also

- **Full session history:** See `session-archive.md`
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
│   ├── settings.json                  # Project permissions (WebSearch, WebFetch)
│   └── commands/
│       └── juno.md                    # Slash command
├── _bmad/
│   ├── custom/
│   │   ├── module.yaml                # Module config
│   │   └── agents/juno/
│   │       ├── juno.agent.yaml        # Agent definition
│   │       ├── JUNO-USER-GUIDE.md     # Documentation
│   │       ├── JUNO-INSTALLATION-GUIDE.md
│   │       ├── sub-agents/            # Specialist sub-agents
│   │       │   ├── raven.agent.yaml   # Research Agent
│   │       │   ├── thistle.agent.yaml # Line Editor
│   │       │   ├── lynx.agent.yaml    # Continuity Checker
│   │       │   ├── masque.agent.yaml  # Character Voice
│   │       │   ├── loom.agent.yaml    # World Builder
│   │       │   └── vestry.agent.yaml  # Knowledge Curator
│   │       └── tools/
│   │           ├── manuscript-import.sh   # Import script
│   │           ├── manuscript-export.sh   # Export script
│   │           ├── epub-stylesheet.css    # EPUB styles
│   │           └── pdf-stylesheet.css     # PDF styles
│   └── _memory/juno-sidecar/
│       ├── project-memory.md          # Live State + session memory
│       ├── projects-registry.md       # Project list
│       ├── active-voice-profile.md    # Voice settings
│       ├── instructions.md            # Preferences + context management
│       ├── writing-directives.md      # Global writing rules
│       ├── session-archive.md         # Past session history
│       ├── directive-templates/       # Pre-built writing directive sets
│       │   ├── starter-pack.md
│       │   ├── literary-fiction.md
│       │   ├── genre-thriller.md
│       │   └── nonfiction-blog.md
│       └── voice-profiles/
│           └── default.md             # Default voice
│
├── my-novel/                          # Example project (created by Juno)
│   ├── 00-genesis/
│   ├── 01-world/
│   ├── 02-characters/
│   ├── 03-plot/
│   ├── 04-outline/
│   ├── 05-drafts/
│   ├── 06-editing/
│   ├── _research/
│   ├── _staging/                      # Sub-agent work products
│   │   ├── raven/
│   │   ├── thistle/
│   │   ├── lynx/
│   │   ├── masque/
│   │   ├── loom/
│   │   └── vestry/
│   └── _knowledge/                    # Curated project knowledge base
│       ├── _index.md
│       ├── research/
│       ├── references/
│       ├── media/
│       ├── glossary/
│       ├── style-references/
│       └── notes/
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

### Test 5: Verify Sub-Agents

1. Check sub-agent files exist:
```bash
ls ~/creative-writing/_bmad/custom/agents/juno/sub-agents/
# Should list: loom, lynx, masque, raven, thistle, vestry .yaml files
```
2. With Juno active and a project open, try `[KB]` to quick-file a test note
3. Verify `_knowledge/` folder was created in your project

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

### Sub-agent web search denied (Raven can't search)

**Cause:** Project-level permissions missing WebSearch/WebFetch

**Fix:**
Ensure `.claude/settings.json` exists in your creative writing directory with:
```json
{
  "permissions": {
    "allow": [
      "WebSearch",
      "WebFetch"
    ]
  }
}
```

If the file was not copied during installation, copy it from source:
```bash
cp /path/to/source/.claude/settings.json ~/creative-writing/.claude/
```

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
cp -r /path/to/new/_bmad/custom/agents/juno/sub-agents/ ~/creative-writing/_bmad/custom/agents/juno/
cp -r /path/to/new/_bmad/custom/agents/juno/tools/ ~/creative-writing/_bmad/custom/agents/juno/

# Copy updated slash command, project config, and permissions
cp /path/to/new/.claude/commands/juno.md ~/creative-writing/.claude/commands/
cp /path/to/new/.claude/settings.json ~/creative-writing/.claude/
cp /path/to/new/CLAUDE.md ~/creative-writing/

# Ensure scripts are executable
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh

# Your memory is preserved in place
```

### Migrating Memory Templates

If you are updating from an earlier version, your `project-memory.md` template may be missing tracking sections. The current format uses a **Live State** block at the top for incremental session saving. To migrate:

1. Replace your `project-memory.md` with the fresh template from Step 4 above
2. Re-enter your active project details in the "Active Project" section
3. Story tracking sections (Subplots, Themes, Foreshadowing) remain the same format

Your `instructions.md` also has new sections for Context Management Preferences, session management, and genre defaults.

### Migrating to Sub-Agent Support

If updating from a version without sub-agents (pre-49 commands), note:

- **New folder:** `sub-agents/` under `_bmad/custom/agents/juno/` contains 6 agent YAML files. Copy the entire folder.
- **Existing projects** will automatically get `_staging/` and `_knowledge/` folders when you first summon a sub-agent or use `[KB]`. No manual migration needed.
- **New projects** created with `[GS]` Genesis will scaffold these folders automatically.
- **New commands:** `[KB]`, `[RN]`, `[TS]`, `[LX]`, `[MQ]`, `[LM]`, `[VY]`, `[AP]` — see the User Guide for details.

**Note:** The agent YAML (`juno.agent.yaml`) supports 50 commands with 32 detailed prompts. This is expected and does not affect performance since prompts are loaded on demand.

### Migrating to Session Continuity

If updating from a version without session continuity (pre-50 commands), note:

- **New file:** `session-archive.md` in the sidecar. Create an empty one or copy from source — Juno's `[SR]` Session Recap will populate it.
- **New folder:** `directive-templates/` in the sidecar with 4 pre-built templates (starter-pack, literary-fiction, genre-thriller, nonfiction-blog). Copy from source to enable `[WD]` > Load Template.
- **project-memory.md format changed:** The new format uses a Live State block at the top for incremental saves. If your existing project-memory.md uses the old format, replace it with the fresh template from Step 4 and re-enter your project details, or let Juno reformat it on first activation.
- **instructions.md updated:** Now includes Context Management Preferences section. Copy fresh or add manually.
- **New command:** `[SA]` Session Archive — browse past session history without loading the full archive.

### Partial Update (Agent Only)

If only the agent definition changed:

```bash
cp /path/to/new/_bmad/custom/agents/juno/juno.agent.yaml \
   ~/creative-writing/_bmad/custom/agents/juno/
cp -r /path/to/new/_bmad/custom/agents/juno/sub-agents/ \
   ~/creative-writing/_bmad/custom/agents/juno/
```

### Fresh Install (Reset Everything)

If you want to start completely fresh:

```bash
# Remove old installation
rm -rf ~/creative-writing/_bmad
rm -rf ~/creative-writing/.claude/commands/juno.md
rm -f ~/creative-writing/.claude/settings.json
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

# Copy BMAD framework (includes sub-agents)
mkdir -p "$DEST/_bmad"
cp -r "$SOURCE/_bmad/custom" "$DEST/_bmad/"
cp -r "$SOURCE/_bmad/_memory" "$DEST/_bmad/"

# Copy slash command and project settings
mkdir -p "$DEST/.claude/commands"
cp "$SOURCE/.claude/commands/juno.md" "$DEST/.claude/commands/"
cp "$SOURCE/.claude/settings.json" "$DEST/.claude/"

# Copy project config
cp "$SOURCE/CLAUDE.md" "$DEST/"

# Set permissions
chmod -R u+rw "$DEST/_bmad"
chmod -R u+rw "$DEST/.claude"
chmod +x "$DEST/_bmad/custom/agents/juno/tools/"*.sh

# Verify sub-agents were copied
AGENT_COUNT=$(ls "$DEST/_bmad/custom/agents/juno/sub-agents/"*.yaml 2>/dev/null | wc -l)
echo "Installed $AGENT_COUNT sub-agents"

# Verify directive templates were copied
TEMPLATE_COUNT=$(ls "$DEST/_bmad/_memory/juno-sidecar/directive-templates/"*.md 2>/dev/null | wc -l)
echo "Installed $TEMPLATE_COUNT directive templates"

# Verify session archive exists
if [ -f "$DEST/_bmad/_memory/juno-sidecar/session-archive.md" ]; then
  echo "Session archive: ready"
else
  echo "Note: session-archive.md not found — Juno will create it on first [SR]"
fi

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
