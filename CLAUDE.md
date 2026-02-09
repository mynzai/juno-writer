# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a creative writing workspace powered by the BMAD framework with a custom agent called **Juno** — a Creative Writing Orchestrator that guides writers from seed idea to polished manuscript.

## Primary Command

```
/juno                    # Activate Juno (resume last project or create new)
/juno my-novel           # Open specific project folder
```

## Architecture

```
/creative writing/
├── .claude/commands/juno.md      # Slash command activation
├── _bmad/
│   ├── core/                     # BMAD core framework (don't modify)
│   ├── bmm/                      # BMAD method module (don't modify)
│   ├── custom/                   # Custom agents and workflows
│   │   └── agents/juno/          # Juno agent definition
│   └── _memory/
│       └── juno-sidecar/         # Juno's persistent memory
│           ├── project-memory.md
│           ├── projects-registry.md
│           ├── active-voice-profile.md
│           ├── instructions.md
│           └── voice-profiles/
└── {project-folders}/            # Writing projects created by Juno
```

## Juno Agent Files

| File | Purpose |
|------|---------|
| `_bmad/custom/agents/juno/juno.agent.yaml` | Core agent definition with prompts and menu |
| `.claude/commands/juno.md` | Slash command with persona and greeting |
| `_bmad/_memory/juno-sidecar/` | Persistent memory across sessions |

## Key Juno Commands

- `[GS]` Genesis — Create new project with genre-specific scaffolding
- `[WR]` Write — Generate content (Write-For-Me mode)
- `[HU]` Humanize — Run humanizer skill on content (optional)
- `[RS]`/`[DR]` Research — Web search for topics
- `[FC]` Fact Check — Verify claims against sources
- `[CV]` Capture — Extract author DNA from text samples
- `[CC]` Continuity — Check consistency across project docs

## Project Structure (created by Juno)

For novels and long-form work:
```
my-novel/
├── 00-genesis/         # Vision and seed idea
├── 01-world/           # Lore, settings
├── 02-characters/      # Cast profiles
├── 03-plot/            # Structure, timeline
├── 04-outline/         # Scene-by-scene plan
├── 05-drafts/          # Manuscript
├── 06-editing/         # Revisions
└── _research/          # Research notes and fact-checks
```

## Modifying Juno

- Agent definition: `_bmad/custom/agents/juno/juno.agent.yaml`
- Activation behavior: `.claude/commands/juno.md`
- Memory files: `_bmad/_memory/juno-sidecar/`
- Add voice profiles: `_bmad/_memory/juno-sidecar/voice-profiles/`

## Documentation

- `_bmad/custom/agents/juno/JUNO-USER-GUIDE.md` — Complete usage guide
- `_bmad/custom/agents/juno/JUNO-INSTALLATION-GUIDE.md` — Installation on other machines
