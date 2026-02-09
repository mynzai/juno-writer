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

| Tool | Purpose |
|------|---------|
| **Git** | Version control for your writing projects |
| **VS Code** | IDE with Claude Code extension for visual editing |

---

## What You Need to Copy

Juno consists of three components that must be installed together:

### 1. Slash Command (Required)

```
.claude/commands/juno.md
```

This file enables the `/juno` activation command.

### 2. Agent Definition (Required)

```
_bmad/custom/agents/juno/
├── juno.agent.yaml        # Core agent definition
├── JUNO-USER-GUIDE.md     # User documentation
└── JUNO-INSTALLATION-GUIDE.md  # This file
```

Plus the module configuration:
```
_bmad/custom/module.yaml
```

### 3. Sidecar Memory (Required)

```
_bmad/_memory/juno-sidecar/
├── project-memory.md       # Active project context
├── projects-registry.md    # All projects tracker
├── active-voice-profile.md # Current writing voice
├── instructions.md         # User preferences
├── README.md               # Sidecar documentation
└── voice-profiles/
    └── default.md          # Default voice profile
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
    │       └── JUNO-INSTALLATION-GUIDE.md
    └── _memory/juno-sidecar/
        ├── project-memory.md
        ├── projects-registry.md
        ├── active-voice-profile.md
        ├── instructions.md
        ├── README.md
        └── voice-profiles/
            └── default.md
```

### Step 3: Install the Slash Command

The slash command must be placed in your `.claude/commands/` directory:

**Option A: Project-level (recommended)**

Install in your creative writing directory so it's available when you're in that folder:

```bash
mkdir -p ~/creative-writing/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/creative-writing/.claude/commands/
```

**Option B: Global installation**

Install in your home directory so it's available everywhere:

```bash
mkdir -p ~/.claude/commands
cp /path/to/source/.claude/commands/juno.md ~/.claude/commands/
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

Ensure all files are readable:

```bash
chmod -R u+rw ~/creative-writing/_bmad
chmod -R u+rw ~/creative-writing/.claude
```

---

## Directory Structure

After installation, your creative writing workspace should look like this:

```
~/creative-writing/                    # Your project root
├── .claude/
│   └── commands/
│       └── juno.md                    # Slash command
├── _bmad/
│   ├── custom/
│   │   ├── module.yaml                # Module config
│   │   └── agents/juno/
│   │       ├── juno.agent.yaml        # Agent definition
│   │       ├── JUNO-USER-GUIDE.md     # Documentation
│   │       └── JUNO-INSTALLATION-GUIDE.md
│   └── _memory/juno-sidecar/
│       ├── project-memory.md          # Session memory
│       ├── projects-registry.md       # Project list
│       ├── active-voice-profile.md    # Voice settings
│       ├── instructions.md            # Preferences
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
cp /path/to/new/_bmad/custom/agents/juno/* ~/creative-writing/_bmad/custom/agents/juno/
cp /path/to/new/.claude/commands/juno.md ~/creative-writing/.claude/commands/

# Your memory is preserved in place
```

### Migrating Memory Templates

If you are updating from a version with fewer commands (23 commands) to the expanded version (40 commands), your `project-memory.md` template may be missing new tracking sections. To add them manually, append these sections after "Quick Context" in your existing `project-memory.md`:

- **Word Count Tracking** — target, current total, daily goal, session log table
- **Subplot Tracking** — thread status table (populated by `[SB]`)
- **Theme & Motif Tracking** — element tracking table (populated by `[TH]`)
- **Foreshadowing Ledger** — setup/payoff status table (populated by `[FL]`)

See the fresh `project-memory.md` template for the exact format. Your `instructions.md` also has new preference sections for session management and genre defaults.

**Note:** The agent YAML (`juno.agent.yaml`) has grown significantly to support 40 commands with 26 detailed prompts. This is expected and does not affect performance since prompts are loaded on demand.

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

# Copy everything new
cp -r /path/to/new/_bmad ~/creative-writing/
cp -r /path/to/new/.claude ~/creative-writing/
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

# Create destination
mkdir -p "$DEST"

# Copy BMAD framework
mkdir -p "$DEST/_bmad"
cp -r "$SOURCE/_bmad/custom" "$DEST/_bmad/"
cp -r "$SOURCE/_bmad/_memory" "$DEST/_bmad/"

# Copy slash command
mkdir -p "$DEST/.claude/commands"
cp "$SOURCE/.claude/commands/juno.md" "$DEST/.claude/commands/"

# Set permissions
chmod -R u+rw "$DEST/_bmad"
chmod -R u+rw "$DEST/.claude"

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
