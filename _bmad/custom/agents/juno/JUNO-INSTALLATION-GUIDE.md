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
.claude/commands/masque.md         # Standalone character embodiment — enables /masque
.claude/commands/loom.md           # Standalone world-building — enables /loom
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
│   ├── vestry.agent.yaml          # Knowledge Curator
│   └── wraith.agent.yaml          # Slop Slayer (AI-pattern detection)
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

### Step 1: Clone the Repository

```bash
git clone https://github.com/mynzai/juno-writer.git ~/creative-writing
cd ~/creative-writing
```

This gives you everything: the BMAD framework, Juno's agent definition, sub-agents, slash commands, project settings, and starter memory templates. Your writing projects will live alongside the system files — they're automatically gitignored so they stay private.

**Skip to [Step 4](#step-4-reset-memory-files-fresh-start) if you want a clean slate, or [Step 5](#step-5-verify-file-permissions) to finish setup.**

If you prefer a manual installation (without git), continue with Steps 2-3 below.

### Step 2: Manual Install — Copy the BMAD Framework

> *Skip this step if you cloned the repository in Step 1.*

Copy the entire `_bmad` folder to your creative writing directory:

```bash
mkdir -p ~/creative-writing
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
    │       │   ├── vestry.agent.yaml
    │       │   └── wraith.agent.yaml
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

### Step 3: Manual Install — Slash Commands, Config, and Permissions

> *Skip this step if you cloned the repository in Step 1.*

The slash commands, CLAUDE.md, and project settings must be placed in your creative writing directory:

**Option A: Project-level (recommended)**

Install in your creative writing directory so it's available when you're in that folder:

```bash
# Slash commands
mkdir -p ~/creative-writing/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/creative-writing/.claude/commands/
cp /path/to/source/.claude/commands/masque.md ~/creative-writing/.claude/commands/
cp /path/to/source/.claude/commands/loom.md ~/creative-writing/.claude/commands/

# Project config
cp /path/to/source/CLAUDE.md ~/creative-writing/

# Project permissions (enables WebSearch/WebFetch for sub-agents like Raven)
cp /path/to/source/.claude/settings.json ~/creative-writing/.claude/
```

**Option B: Global slash commands**

Install the slash commands in your home directory so they're available everywhere (CLAUDE.md and settings should still go in the project directory):

```bash
mkdir -p ~/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/.claude/commands/
cp /path/to/source/.claude/commands/masque.md ~/.claude/commands/
cp /path/to/source/.claude/commands/loom.md ~/.claude/commands/
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
│       ├── juno.md                    # Juno orchestrator command
│       ├── masque.md                  # Standalone character embodiment command
│       └── loom.md                    # Standalone world-building command
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
│   │       │   ├── vestry.agent.yaml  # Knowledge Curator
│   │       │   └── wraith.agent.yaml  # Slop Slayer
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
│   │   ├── vestry/
│   │   └── wraith/
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

### Test 1: Check Slash Commands

```bash
cd ~/creative-writing
claude
```

Then type:
```
/juno
```

Juno should greet you and ask if you're continuing an existing project or starting new.

To verify Masque standalone:
```
/masque
```

Masque should greet you and list available characters (or note no active project).

To verify Loom standalone:
```
/loom
```

Loom should greet you and present the world-building menu (or note no active project).

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
# Should list: loom, lynx, masque, raven, thistle, vestry, wraith .yaml files
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

### Git Pull (Recommended)

If you installed by cloning the repo, updating is simple:

```bash
cd ~/creative-writing

# Backup your memory (your session state, voice profiles, projects registry)
cp -r _bmad/_memory/juno-sidecar ~/juno-sidecar-backup

# Reset tracked memory files to avoid merge conflicts, then pull
git checkout -- _bmad/_memory/juno-sidecar/
git pull

# Restore your memory
cp -r ~/juno-sidecar-backup/* _bmad/_memory/juno-sidecar/
rm -rf ~/juno-sidecar-backup
```

**What gets updated:** Agent definition, sub-agents (raven, thistle, lynx, masque, loom, vestry, wraith), slash commands (`/juno`, `/masque`, `/loom`), project settings, CLAUDE.md, tools, directive templates, documentation.

**What is preserved:** Your memory files (project-memory.md, projects-registry.md, active-voice-profile.md, instructions.md, writing-directives.md, session-archive.md, voice-profiles/), and all writing projects (gitignored).

### Manual Update (Without Git)

If you installed manually without cloning:

```bash
# Download or clone the latest source to a temporary location
git clone https://github.com/mynzai/juno-writer.git /tmp/juno-update

# Backup your memory
cp -r ~/creative-writing/_bmad/_memory/juno-sidecar ~/juno-sidecar-backup

# Copy updated system files
cp -r /tmp/juno-update/_bmad/custom ~/creative-writing/_bmad/
cp /tmp/juno-update/.claude/commands/juno.md ~/creative-writing/.claude/commands/
cp /tmp/juno-update/.claude/commands/masque.md ~/creative-writing/.claude/commands/
cp /tmp/juno-update/.claude/commands/loom.md ~/creative-writing/.claude/commands/
cp /tmp/juno-update/.claude/settings.json ~/creative-writing/.claude/
cp /tmp/juno-update/CLAUDE.md ~/creative-writing/

# Restore your memory
cp -r ~/juno-sidecar-backup/* ~/creative-writing/_bmad/_memory/juno-sidecar/

# Ensure scripts are executable
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh

# Clean up
rm -rf /tmp/juno-update ~/juno-sidecar-backup
```

### Fresh Install (Reset Everything)

If you want to start completely fresh, removing all memory and session history:

```bash
rm -rf ~/creative-writing/_bmad ~/creative-writing/.claude ~/creative-writing/CLAUDE.md
git clone https://github.com/mynzai/juno-writer.git ~/creative-writing
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh
```

Your writing project folders are untouched (they live outside the tracked files).

---

## Quick Install

```bash
git clone https://github.com/mynzai/juno-writer.git ~/creative-writing
chmod +x ~/creative-writing/_bmad/custom/agents/juno/tools/*.sh
cd ~/creative-writing && claude
# Then type: /juno
```

---

## Support

- **Repository:** [github.com/mynzai/juno-writer](https://github.com/mynzai/juno-writer)
- **User Guide:** See `JUNO-USER-GUIDE.md` for usage instructions
- **Agent Definition:** See `juno.agent.yaml` for technical details
- **Issues:** Check troubleshooting section above or open an issue on GitHub

---

*Juno travels with you. Install once, write anywhere.*
