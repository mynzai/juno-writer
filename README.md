# Juno — Creative Writing Orchestrator

Juno is a creative writing agent for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) that guides writers from seed idea to polished manuscript.

She manages your project phases, maintains context across sessions through living documentation, and brings deep craft knowledge to every stage of writing — from worldbuilding and character development to pacing analysis and manuscript export.

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/mynzai/juno-writer/main/install.sh | bash
```

Or specify a custom directory:

```bash
curl -fsSL https://raw.githubusercontent.com/mynzai/juno-writer/main/install.sh | bash -s -- ~/my-writing
```

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed and authenticated
- macOS, Linux, or Windows (WSL)

## Usage

```bash
cd ~/creative-writing
claude
/juno                    # Start Juno (resume last project or create new)
/juno my-novel           # Open a specific project
```

Juno will greet you and either resume your last project or walk you through creating a new one.

## What Juno Does

### 41 Commands Across 9 Categories

| Category | Commands |
|----------|----------|
| **Project Management** | List Projects, Switch, Open, Genesis, Status |
| **Story & World** | Enhance, Cast, Timeline, Continuity, Spark |
| **Research & Knowledge** | Research, Deep Research, Fact Check, Sources |
| **Story Architecture** | Subplot Weave, Foreshadowing, Theme Tracker, Outline Reconciliation |
| **Craft & Analysis** | Critique, Pacing Map, Dialogue Workshop, Hook Analysis |
| **Reader Perspective** | Beta Reader, Sensitivity Scan, Kill Darlings |
| **Phase & Progress** | Next, Review, Import, Word Count, Session Recap, Summaries |
| **Writing & Production** | Writing Directives, Write, Write-As, Scene Surgery, Humanize, Export, Query & Synopsis |
| **Voice & Style** | Voice, Capture Voice, Blend Voices |

### Key Features

- **Genesis** — Create a new project with genre-specific scaffolding (novels, screenplays, poetry, essays, blog posts, and more)
- **Voice Capture** — Extract "author DNA" from sample text to write in your style
- **Session Memory** — Picks up exactly where you left off across sessions
- **Research Integration** — Web search and fact-checking built into the writing flow
- **Craft Analysis** — Pacing maps, dialogue workshops, hook analysis, beta reader simulation
- **Writing Directives** — Set hard rules for how Juno writes (banned words, style constraints, formatting rules)
- **Multi-Project** — Manage multiple writing projects with easy switching

### Supported Genres

Novel, Novella, Short Story, Short Story Collection, Blog Post, Article, Essay, Screenplay, Stage Play, Poetry Collection, Memoir, and custom formats.

## Project Structure

When you create a project, Juno scaffolds it like this (varies by genre):

```
my-novel/
├── 00-genesis/         # Vision and seed idea
├── 01-world/           # Lore, settings, research
├── 02-characters/      # Cast profiles
├── 03-plot/            # Structure, timeline, subplots
├── 04-outline/         # Scene-by-scene plan
├── 05-drafts/          # Manuscript chapters
├── 06-editing/         # Revisions
└── _research/          # Research notes and citations
```

## Updating

Re-run the installer to update. It will detect the existing installation and offer to update agent files while preserving your memory and projects:

```bash
curl -fsSL https://raw.githubusercontent.com/mynzai/juno-writer/main/install.sh | bash
```

## Manual Installation

If you prefer not to use the install script:

1. Clone this repo
2. Copy `.claude/commands/juno.md` to your workspace
3. Copy `_bmad/` to your workspace
4. Copy `CLAUDE.md` to your workspace root
5. Run `claude` in your workspace and type `/juno`

See [JUNO-INSTALLATION-GUIDE.md](_bmad/custom/agents/juno/JUNO-INSTALLATION-GUIDE.md) for detailed manual instructions.

## Documentation

- [User Guide](_bmad/custom/agents/juno/JUNO-USER-GUIDE.md) — Complete usage documentation
- [Installation Guide](_bmad/custom/agents/juno/JUNO-INSTALLATION-GUIDE.md) — Detailed installation and troubleshooting

## How It Works

Juno runs as a slash command inside Claude Code. When you type `/juno`, it loads a ~1100-line agent definition that gives Claude a specialized creative writing persona with structured prompts for every stage of the writing process. Your project state is persisted in markdown files that Juno reads and updates each session.

No external services, no API keys beyond Claude Code itself, no dependencies.

## License

MIT
