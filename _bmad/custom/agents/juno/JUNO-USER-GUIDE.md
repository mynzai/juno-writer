# Juno User Guide

A complete guide to using Juno, your Creative Writing Orchestrator.

---

## Table of Contents

1. [Activating Juno](#activating-juno)
2. [First-Time Setup](#first-time-setup)
3. [Project Management](#project-management)
4. [The Creative Workflow](#the-creative-workflow)
5. [Command Reference](#command-reference)
6. [The Sub-Agent Fleet](#the-sub-agent-fleet)
7. [Masque Standalone Command](#masque-standalone-command)
8. [Knowledge Base](#knowledge-base)
9. [Staging & Approval](#staging--approval)
10. [Research & Knowledge](#research--knowledge)
11. [Voice & Style Features](#voice--style-features)
12. [Writing Directives](#writing-directives)
13. [Writing Assistance](#writing-assistance)
14. [Story Architecture Tools](#story-architecture-tools)
15. [Craft & Analysis Tools](#craft--analysis-tools)
16. [Reader Perspective Tools](#reader-perspective-tools)
17. [Progress & Accountability](#progress--accountability)
18. [Production & Polish Tools](#production--polish-tools)
19. [Common Workflows](#common-workflows)
20. [Tips & Best Practices](#tips--best-practices)

---

## Activating Juno

### Basic Activation

```
/juno
```

Opens Juno. If you have an active project, Juno welcomes you back to it. If not, Juno asks the first question:

> **Note:** There is also a standalone `/masque` command for interactive character sessions -- see [Masque Standalone Command](#masque-standalone-command) below.

> *"Tell me — are we continuing an existing project, or beginning something new?"*

- **Continuing existing** — Juno shows your registered projects or lets you open a folder
- **Starting new** — Juno asks what genre/form you're writing

### The Genre Question

When starting a new project, Juno asks:

> *"Every form has its own rhythms and demands. What are we crafting together?"*

**Available genres:**

| Genre | Description |
|-------|-------------|
| Novel | Long-form fiction with chapters, arcs, deep character work |
| Novella | Mid-length fiction, focused and intense |
| Short Story | Complete narrative in compact form |
| Short Story Collection | Multiple stories, possibly linked |
| Blog Post | Informal, voice-driven, web-native |
| Article | Informative or persuasive non-fiction |
| Essay | Personal or academic exploration of ideas |
| Screenplay | Visual storytelling for film/TV |
| Stage Play | Dialogue-driven theatrical work |
| Poetry Collection | Verse in various forms |
| Memoir | Personal narrative non-fiction |
| Other | Describe your own form |

Juno then scaffolds your project with a structure appropriate to that genre.

### Activate with Specific Project

```
/juno my-novel
```

Opens Juno and immediately activates the `my-novel` project folder. The path is relative to your creative writing directory. Skips the initial question since you've specified a project.

### Examples

| Command | What Happens |
|---------|--------------|
| `/juno` | Ask: existing or new? Then resume or create |
| `/juno my-novel` | Open the my-novel folder directly |
| `/juno short-stories` | Open the short-stories folder |
| `/juno drafts/new-idea` | Open a nested folder |

---

## First-Time Setup

### Starting Fresh (No Existing Work)

1. Run `/juno`
2. Juno asks: *"Are we continuing an existing project, or beginning something new?"*
3. Choose **"Start a new project"**
4. Juno asks: *"What are we crafting together?"* — select your genre
5. Juno proceeds to Genesis, guiding you through:
   - Naming your project
   - Genre-specific questions (logline for screenplays, thesis for essays, etc.)
   - Competitive landscape exploration
   - Seed idea deepening through Emotional Core, Structural, and Audience questions
   - Creating a genre-appropriate folder structure

**Genre affects structure:**
- **Novel** gets full 7-phase structure with chapter folders
- **Blog Post** gets streamlined genesis, drafts, editing
- **Short Story** gets minimal single-file draft structure
- **Screenplay** gets scene-based formatting structure

### With Existing Work

1. Run `/juno`
2. Juno asks: *"Existing or new?"*
3. Choose **"Continue existing project"**
4. Select from registered projects, or use `[OP]` to open a folder path
5. Optionally use `[IM]` to import documents (outlines, lore, characters)
6. Juno parses your documents and integrates them into the project structure

---

## Project Management

### Creating a New Project

**Command:** `[GS]` Genesis

Juno guides you through:
1. Project name and folder location
2. Genre-specific questions tailored to your form
3. Competitive landscape — what you admire, what gap your work fills
4. Seed idea deepening through Emotional Core, Structural, and Audience questions
5. Enhancement approaches to expand and deepen the idea
6. Vision capture in `project-vision.md`
7. Automatic folder scaffolding

**Result:** A new project folder with this structure:

```
/your-project-name/
├── 00-genesis/
│   └── project-vision.md
├── 01-world/
├── 02-characters/
├── 03-plot/
├── 04-outline/
├── 05-drafts/
├── 06-editing/
├── _research/
├── _staging/              # Sub-agent work products (pending approval)
│   ├── raven/
│   ├── thistle/
│   ├── lynx/
│   ├── masque/
│   ├── loom/
│   └── vestry/
└── _knowledge/            # Curated project knowledge base
    ├── _index.md
    ├── research/
    ├── references/
    ├── media/
    ├── glossary/
    ├── style-references/
    └── notes/
```

### Listing All Projects

**Command:** `[LP]` List Projects

Displays all registered projects with:
- Project name
- Folder path
- Current phase
- Last touched date

Select any project by number to switch to it.

### Switching Projects

**Command:** `[SW]` Switch

Quick switch between registered projects. Juno will:
1. Save context for current project
2. Load the new project's context
3. Orient you to where you left off

### Opening a Project by Path

**Command:** `[OP]` Open

Use when you have a folder that isn't registered yet:
1. Provide the folder path
2. Juno verifies it exists
3. Registers it if new
4. Sets it as active

### Checking Project Status

**Command:** `[ST]` Status

Shows:
- Current phase
- Progress within phase
- Word count (if drafts exist)
- Last working position
- Open threads and decisions
- Recommended next action

---

## The Creative Workflow

Juno guides projects through six phases. Each phase has a gatekeeper review before advancing.

### Phase 0: Genesis

**Focus:** Capture the seed idea and vision

**Documents:**
- `project-vision.md` — Core vision, themes, tone

**Activities:**
- Enhancement questioning to deepen the idea
- Genre and audience definition
- Competitive landscape exploration
- Initial spark capture

### Phase 1: World

**Focus:** Build the story's world and setting

**Documents:**
- `lore-bible.md` — World rules, history, geography
- `setting-details.md` — Specific locations and atmosphere

**Activities:**
- Worldbuilding exploration
- Consistency establishment
- Sensory detail development

### Phase 2: Characters

**Focus:** Develop the cast

**Documents:**
- `cast-overview.md` — All characters at a glance
- `character-profiles/` — Individual deep dives
- `relationship-map.md` — Connections between characters

**Activities:**
- Character creation and psychology
- Voice development for dialogue
- Arc planning (want, need, flaw, trajectory)

### Phase 3: Plot

**Focus:** Structure the story

**Documents:**
- `plot-structure.md` — Overall story architecture
- `timeline.md` — Chronological events
- `conflict-tracker.md` — Tensions and stakes
- `subplot-weave.md` — Story thread mapping
- `foreshadowing-ledger.md` — Setup and payoff tracking
- `theme-motif-tracker.md` — Thematic element tracking

**Activities:**
- Story structure selection
- Key plot point definition
- Subplot integration
- Theme and motif planning

### Phase 4: Outline

**Focus:** Scene-by-scene planning

**Documents:**
- `chapter-outline.md` — Chapter-level breakdown
- `scene-cards/` — Individual scene plans
- `pacing-map.md` — Rhythm and flow

**Activities:**
- Scene sequencing
- Beat planning
- Transition mapping
- POV assignments

### Phase 5: Drafts

**Focus:** Write the manuscript

**Documents:**
- `drafts/` — Actual chapter/scene drafts
- `draft-notes.md` — Working notes during drafting
- `chapter-summaries.md` — Auto-generated chapter reference

**Activities:**
- Writing (with optional Write-For-Me mode)
- Scene generation
- Dialogue creation
- Word count tracking

### Phase 6: Editing

**Focus:** Refine and polish

**Documents:**
- `revision-notes.md` — Edit tracking
- `continuity-log.md` — Consistency issues found/fixed
- `darlings-morgue.md` — Preserved cut passages
- `submission/` — Query letter, synopsis, pitch materials

**Activities:**
- Continuity checking
- Line editing
- Pacing analysis
- Submission material preparation

### Phase Transitions

When you feel ready to advance:

1. Use `[RV]` Review for a gatekeeper check
2. Juno reviews all phase documents against specific checklists
3. Identifies any gaps or issues
4. If ready: celebrates the milestone and unlocks next phase
5. If not ready: provides specific items to address, ordered by importance

---

## Command Reference

### Project Management

| Command | Name | Description |
|---------|------|-------------|
| `[LP]` | List Projects | Show all registered projects |
| `[SW]` | Switch | Switch to a different project |
| `[OP]` | Open | Open project by folder path |
| `[GS]` | Genesis | Create new project from seed idea |
| `[ST]` | Status | Show current project progress |

### Story & World

| Command | Name | Description |
|---------|------|-------------|
| `[EN]` | Enhance | Run enhancement questioning (12 approaches) |
| `[CS]` | Cast | Show character overview |
| `[TL]` | Timeline | Display story timeline |
| `[CC]` | Continuity | Run full continuity check |
| `[SP]` | Spark | Get random inspiration based on project |

### Research & Knowledge

| Command | Name | Description |
|---------|------|-------------|
| `[RS]` | Research | Investigate a topic with web search |
| `[DR]` | Deep Research | Thorough multi-angle investigation (7-15 searches) |
| `[FC]` | Fact Check | Verify claims in your content with confidence scoring |
| `[SRC]` | Sources | View saved research and citations |

### Story Architecture

| Command | Name | Description |
|---------|------|-------------|
| `[SB]` | Subplot Weave | Map and manage story threads |
| `[FL]` | Foreshadowing | Track setups and payoffs |
| `[TH]` | Theme Tracker | Track motifs, symbols, and payoffs |
| `[OR]` | Outline Reconciliation | Compare plan vs actual draft |

### Craft & Analysis

| Command | Name | Description |
|---------|------|-------------|
| `[CQ]` | Critique | Multi-perspective workshop feedback |
| `[PM]` | Pacing Map | Analyze rhythm and tension profile |
| `[DW]` | Dialogue Workshop | Improve dialogue craft |
| `[HK]` | Hook Analysis | Evaluate openings and cliffhangers |

### Reader Perspective

| Command | Name | Description |
|---------|------|-------------|
| `[BR]` | Beta Reader | Simulate reader perspectives |
| `[SN]` | Sensitivity | Scan for representation concerns |
| `[KD]` | Kill Darlings | Find beautiful but unneeded passages |

### Phase & Progress

| Command | Name | Description |
|---------|------|-------------|
| `[NX]` | Next | Get recommended next action |
| `[RV]` | Review | Gatekeeper review for phase completion |
| `[IM]` | Import | Import existing work into project |
| `[WC]` | Word Count | Track progress, goals, and velocity |
| `[SR]` | Session Recap | Summarize this session's work |
| `[SM]` | Summaries | Generate chapter summaries |

### Writing & Production

| Command | Name | Description |
|---------|------|-------------|
| `[WD]` | Writing Directives | Set rules or load pre-built templates for writing |
| `[WR]` | Write | Generate content (Write-For-Me mode) |
| `[WA]` | Write-As | Write using a specific voice profile |
| `[SS]` | Scene Surgery | Micro-edit a single scene |
| `[HU]` | Humanize | Remove AI patterns from content |
| `[EX]` | Export | Compile & convert manuscript (md/docx/epub/pdf) |
| `[QR]` | Query & Synopsis | Generate submission materials |

### Knowledge Base

| Command | Name | Description |
|---------|------|-------------|
| `[KB]` | Knowledge Base | Quick-file material into the project knowledge base |

### Sub-Agents

| Command | Name | Description |
|---------|------|-------------|
| `[RN]` | Raven | Deploy research agent for deep knowledge seeking |
| `[TS]` | Thistle | Deploy line editor for prose refinement |
| `[LX]` | Lynx | Deploy continuity checker for consistency auditing |
| `[MQ]` | Masque | Embody a character (inline), or use `/masque` standalone |
| `[LM]` | Loom | Deploy world builder for lore and systems |
| `[VY]` | Vestry | Deploy knowledge curator for archive management |
| `[AP]` | Approve | Review and approve sub-agent work from staging |

### Voice & Style

| Command | Name | Description |
|---------|------|-------------|
| `[VO]` | Voice | Manage voice profiles |
| `[CV]` | Capture | Capture author DNA from sample text |
| `[VB]` | Blend | Blend two voice profiles together |

---

## The Sub-Agent Fleet

Juno can summon specialized agents to handle focused tasks. Each agent has its own persona, expertise, and tools. Five of them (Raven, Thistle, Lynx, Loom, Vestry) work independently in the background, writing their output to a staging area for your review. Nothing they produce enters your canonical project folders until you approve it through Juno.

**Masque is the exception** -- she requires live interactive conversation, so she works differently. Within Juno, `[MQ]` has Juno adopt Masque's persona inline. You can also use `/masque` as a standalone command for dedicated character sessions outside of Juno.

### The Agents

| Agent | Trigger | Role | Personality |
|-------|---------|------|-------------|
| **Raven** | `[RN]` | Research Agent | Measured, deliberate, enigmatic. Returns with knowledge like Odin's ravens. Distinguishes between what she knows, suspects, and cannot verify. |
| **Thistle** | `[TS]` | Line Editor | Sharp, economical, dry wit. Tells you a sentence is bloated without hesitating, but respects your voice. Practices what she preaches. |
| **Lynx** | `[LX]` | Continuity Checker | Calm, observant, precise. Reads like a predator tracking prey. Never judgmental -- just states the facts and lets you decide. |
| **Masque** | `[MQ]` | Character Voice | Warm, theatrical, perceptive. When she becomes a character, the transformation is total. After surfacing, offers insights the writer may not have realized. |
| **Loom** | `[LM]` | Lore & World Builder | Expansive, curious, thinks in systems. Asks "But what do the common people eat?" Builds worlds that feel lived-in. |
| **Vestry** | `[VY]` | Knowledge Curator | Reverent, orderly, quietly devoted. Considers knowledge sacred. Knows exactly where everything is in the archive. |

### How Summoning Works

For background agents (Raven, Thistle, Lynx, Loom, Vestry):

1. Use the agent's trigger command (e.g., `[RN]` for Raven)
2. Juno asks what task to assign (unless already clear from context)
3. The agent is spawned with your project context
4. The agent works independently -- reading from your project, writing to `_staging/{agent-name}/`
5. When the agent finishes, Juno presents a summary
6. Use `[AP]` Approve to review and promote the work into your project

For Masque (interactive):

1. Use `[MQ]` within Juno, or `/masque` standalone
2. Specify which character to embody
3. You converse directly with the embodied character
4. Say "surface" to end the session and receive actor's notes
5. Transcripts are saved to `_staging/masque/`

### Raven -- Research Agent

**Summon:** `[RN]`

Raven goes out into the world and brings back knowledge. She's more thorough than Juno's built-in research commands because research is her entire focus.

**Raven's Commands (once summoned):**

| Command | Description |
|---------|-------------|
| `[QS]` | Quick Search -- Fast lookup for a specific fact |
| `[SR]` | Standard Research -- Balanced investigation (3-7 searches) |
| `[DI]` | Deep Investigation -- Comprehensive multi-angle research |
| `[VC]` | Verify Claims -- Fact-check content against sources |
| `[CB]` | Compile Briefing -- Assemble research into a single document |

**When to summon Raven:**
- You need thorough, multi-angle research on a topic
- You want research done with explicit credibility tiers and confidence levels
- You need a compiled briefing document for reference
- You want fact-checking with detailed source attribution

**Output:** Research files saved to `_staging/raven/`, ready for your review and promotion to `_knowledge/research/`.

### Thistle -- Line Editor

**Summon:** `[TS]`

Thistle sharpens your prose at the sentence level. She's more focused than Juno's Scene Surgery because editing is all she does.

**Thistle's Commands:**

| Command | Description |
|---------|-------------|
| `[LE]` | Line Edit -- Full sentence-level editing pass |
| `[TP]` | Tighten Prose -- Cut the fat, keep the muscle |
| `[RA]` | Rhythm Analysis -- Analyze sentence and paragraph cadence |
| `[WA]` | Word Audit -- Review vocabulary precision and variety |
| `[DP]` | Dialogue Polish -- Sharpen dialogue craft |

**When to summon Thistle:**
- A chapter is drafted and needs prose refinement
- Dialogue feels flat and needs craft attention
- You want a focused editing pass without other distractions
- You want sentence rhythm analysis

**Output:** Edited files and change logs saved to `_staging/thistle/`. Originals are never touched -- Thistle always presents edits alongside originals for comparison.

### Lynx -- Continuity Checker

**Summon:** `[LX]`

Lynx tracks every name, date, description, location, and rule across your entire manuscript. More thorough than Juno's `[CC]` because continuity is her sole purpose.

**Lynx's Commands:**

| Command | Description |
|---------|-------------|
| `[FA]` | Full Audit -- Complete continuity scan across all documents |
| `[CA]` | Character Audit -- Track one character's consistency |
| `[TA]` | Timeline Audit -- Verify chronological consistency |
| `[WR]` | World Rules -- Check world-building consistency |
| `[SC]` | Spot Check -- Quick check on a specific element |

**When to summon Lynx:**
- You've drafted several chapters and need a consistency sweep
- A character's details feel uncertain across scenes
- You've made timeline changes and need to verify ripple effects
- You want to verify a specific fact ("What color are Elena's eyes?")

**Output:** Audit reports with severity ratings (MINOR/MODERATE/CRITICAL) saved to `_staging/lynx/`. Spot checks are reported directly without files.

### Masque -- Character Voice

**Access:** `[MQ]` within Juno, or `/masque` standalone

Masque is unique among the agents. She doesn't produce documents -- she *becomes* your characters. When embodying a character, the transformation is total: speech patterns, vocabulary, worldview, emotional state, knowledge limitations. You converse directly with your character.

Because Masque requires live interactive conversation, she works differently from the other agents. The other five agents run in the background and return results. Masque needs you in the room.

**Two ways to reach Masque:**

| Method | When to use |
|--------|-------------|
| `[MQ]` within Juno | Quick character check mid-session. Juno adopts Masque's persona, then returns to Juno when you say "surface." |
| `/masque` standalone | Dedicated character session. Deeper exploration without Juno's overhead. Use `/masque Elena` to go directly to a character. |

**Session Modes:**

| Mode | Description |
|------|-------------|
| **Embody** (default) | Free conversation with the character. Ask anything. |
| **Interview** | Structured deep-dive with guided questions across four tracks: Core Identity, Relationships, World & Beliefs, Story & Arc. |
| **Dual Voice** | Two characters in conversation. You watch, interject, or direct. |
| **Dialogue Generation** | Generate scene dialogue while in character. |

**When to use Masque:**
- You want to "talk to" a character to understand them better
- You're stuck on how a character would react in a situation
- Two characters have a conflict and you want to hear both sides
- You need dialogue that sounds authentic to a specific character
- You want to discover things about a character you haven't consciously realized

**The Embodiment Experience:**

1. Tell Juno `[MQ]` or run `/masque` → "I want to talk to Marcus"
2. Masque loads Marcus's profile, his scenes, his place in the timeline
3. She signals the transition: *"Let me find him. ...There he is."*
4. From this point, **Marcus speaks**. Not Masque. Not an AI. Marcus.
5. You can ask questions, present scenarios, challenge him, push him
6. Marcus responds as himself -- including evasions, lies, anger, vulnerability
7. Say **"surface"** to bring Masque back
8. Masque offers actor's notes: hidden motivations, contradictions, surprises
9. Say **"switch to [character]"** to embody someone else without leaving the session

**Dual Voice** is particularly powerful for conflict scenes -- Masque plays both characters, revealing dynamics that monologue cannot.

**Output:** Session transcripts and character insights saved to `_staging/masque/`. Use `[AP]` in Juno to review and approve.

### Masque Standalone Command

The `/masque` command lets you go directly to character embodiment without activating Juno first.

```
/masque              # List available characters and choose
/masque Elena        # Embody Elena immediately
```

**What it does:**
1. Reads your active project from Juno's memory
2. Lists available character profiles from `02-characters/`
3. Loads the full character profile, scenes, timeline, and world context
4. Enters embodiment mode

**During the session:**
- Converse freely with the embodied character
- Say **"interview"** to switch to structured questions
- Say **"dual voice"** and name a second character for a two-character scene
- Say **"switch to [name]"** to change characters
- Say **"surface"** to end embodiment and receive actor's notes

**After the session:**
- Transcripts are saved to `_staging/masque/`
- Return to Juno and use `[AP]` to review and approve insights into your project

### Loom -- Lore & World Builder

**Summon:** `[LM]`

Loom weaves coherent worlds by thinking in systems and ripple effects. She asks the questions nobody else thinks to ask and builds worlds that feel lived-in.

**Loom's Commands:**

| Command | Description |
|---------|-------------|
| `[BW]` | Build -- Create a new world element (location, culture, system, etc.) |
| `[DD]` | Deep Dive -- Explore an existing element in exhaustive depth |
| `[SA]` | Systems Audit -- Verify internal logic of world systems |
| `[RE]` | Ripple Effects -- Trace consequences of a world choice across all domains |
| `[CD]` | Culture -- Build a culture from the ground up |

**When to summon Loom:**
- You're building a new location, culture, or system from scratch
- An existing world element needs more depth and detail
- You want to verify that your world's rules are internally consistent
- You've made a world-building choice and want to trace its consequences
- You need a fully realized culture with daily life, beliefs, and social structure

**Ripple Effects** is Loom's signature capability. Give her a world fact ("Magic requires blood sacrifice" or "The empire just fell") and she traces the consequences across daily life, economy, politics, military, religion, culture, architecture, geography, technology, and social structure.

**Output:** World-building documents saved to `_staging/loom/`, ready for promotion to `01-world/`.

### Vestry -- Knowledge Curator

**Summon:** `[VY]`

Vestry manages your project's knowledge base -- the curated repository of everything you know about your project's world, research, references, and inspiration.

**Vestry's Commands:**

| Command | Description |
|---------|-------------|
| `[IN]` | Intake -- Process and file new material |
| `[CU]` | Catalog -- Rebuild or update the master index |
| `[RK]` | Retrieve -- Find knowledge on a specific topic |
| `[GA]` | Gap Analysis -- Identify what the knowledge base is missing |
| `[RO]` | Reorganize -- Clean up and restructure the archive |

**When to summon Vestry:**
- You've accumulated research and notes that need organizing
- You want to know what's in your knowledge base on a specific topic
- You need a gap analysis -- what research is missing for your project?
- The knowledge base has grown messy and needs restructuring
- You want files from `_staging/raven/` properly cataloged

**Output:** Vestry writes directly to `_knowledge/` (her domain) and to `_staging/vestry/` for reorganization logs and gap analyses.

---

## Knowledge Base

Every project has a `_knowledge/` folder -- a curated repository for all research, references, notes, and inspiration related to your work. Think of it as your project's library.

### Structure

```
{project}/_knowledge/
├── _index.md              # Master catalog -- what's here and where
├── research/              # Processed research findings
├── references/            # Source material, articles, excerpts
├── media/                 # Images, maps, mood boards, inspiration
├── glossary/              # Terms, naming conventions, constructed languages
├── style-references/      # Tone samples, comp titles, craft benchmarks
└── notes/                 # Freeform writer notes, ideas, fragments
```

### Three Ways to Add Knowledge

**1. Quick Intake with `[KB]`** (fastest)

Use Juno's `[KB]` command to drop material into the knowledge base without summoning an agent. Paste text, provide a file path, or describe what you want to save. Juno files it in the right subfolder, adds a metadata header, and updates the index.

Best for: Quick notes, links, stray ideas, reference material you find mid-session.

**2. Through Raven** (for research)

Summon Raven (`[RN]`) to research a topic. Her findings land in `_staging/raven/`. Approve them with `[AP]` and they're routed to `_knowledge/research/` with full source attribution and credibility tiers.

Best for: Thorough research with verified sources, fact-checking, multi-angle investigation.

**3. Through Vestry** (for curation)

Summon Vestry (`[VY]`) for deep knowledge management -- organizing existing material, running gap analyses, cross-referencing entries, or restructuring a messy archive.

Best for: Bulk organization, finding what's missing, maintaining the archive long-term.

### The Master Index

`_knowledge/_index.md` is the master catalog. It lists every item in the knowledge base with:
- File name and path
- Topic tags
- Date added
- Cross-references to related items

Vestry maintains this index. Juno's `[KB]` command also updates it on quick intakes.

### How Other Agents Use the Knowledge Base

The knowledge base isn't just for storage -- it's a resource all agents can draw from:

- **Raven** deposits research; **Vestry** catalogs it
- **Loom** draws on world-building references when creating new elements
- **Masque** uses character research to deepen embodiment
- **Lynx** references the knowledge base when verifying facts
- **Thistle** checks glossary entries and style references when editing

---

## Staging & Approval

Sub-agents never write directly to your canonical project folders. All their work goes to `_staging/` first.

### The Flow

```
Writer requests task → Juno summons agent → Agent works in _staging/ → Juno presents summary → Writer reviews with [AP]
```

### Reviewing Staged Work

**Command:** `[AP]` Approve

When you invoke `[AP]`, Juno scans all `_staging/` subfolders and lists what's there:

| Agent | File | Description | Date |
|-------|------|-------------|------|

For each artifact (or batch), you can:

- **Approve** -- Juno promotes the content to the appropriate canonical folder:
  - Raven research → `_knowledge/research/`
  - Thistle edits → replace originals in `05-drafts/`
  - Lynx audits → `06-editing/continuity-log.md`
  - Masque transcripts → `02-characters/` insights or `_knowledge/notes/`
  - Loom world-building → `01-world/` or relevant subfolder
- **Reject** -- Delete the staging artifact
- **Revise** -- Send back to the agent with notes (re-summon with feedback)
- **Hold** -- Keep in staging for later decision

### Why Staging Matters

The staging area is a proposal space, not a commit. This means:

- You always see what an agent produced before it touches your project
- You can reject work that doesn't fit your vision
- You can request revisions with specific feedback
- Multiple agents can work without risk of overwriting each other
- Your canonical project folders remain clean and writer-controlled

---

## Research & Knowledge

Research is a first-class capability in Juno. Whether you're writing a blog post that needs statistics, a novel set in 1920s Paris, or a memoir that references real events, Juno can investigate topics, verify facts, and build a research library that lives alongside your project.

### When Does Research Happen?

**During Genesis:** For research-heavy genres (articles, blog posts, essays, memoir, historical fiction), Juno will proactively offer to run Deep Research as part of project creation. This means your outline and drafts can be informed by real data from the start.

**On Demand:** Use `[RS]` or `[DR]` anytime during your project to research a topic that comes up during writing.

**Before Publishing:** Use `[FC]` Fact Check to verify all claims in your content before it reaches readers.

**Automatically Recommended:** When you use `[NX]` (Next), Juno checks whether your genre benefits from research and whether your `_research/` folder is empty — if so, research is suggested as a priority step.

### Research Modes

| Mode | Searches | Best For |
|------|----------|----------|
| **Quick** | 1-3 | Specific facts, dates, definitions |
| **Standard** | 3-7 | Background context, general research |
| **Deep** | 7-15 | Comprehensive investigation, multiple angles |
| **Verify** | Varies | Fact-checking existing content |

### Source Credibility

Juno assigns credibility tiers to all sources:
- **Tier 1** (Authoritative): Academic journals, official records, primary sources
- **Tier 2** (Reliable): Established news outlets, expert blogs, published non-fiction
- **Tier 3** (Supplementary): General web, forums, social media, personal blogs

Cross-references findings across sources, flags single-source claims, and presents both sides when sources disagree.

### Genre-Specific Research

Research adapts to what you're writing:

| Genre | Research Focus |
|-------|---------------|
| **Blog Post** | Topic expertise, statistics, quotes, current events, competitor analysis |
| **Article** | Primary sources, expert opinions, data, counterarguments, fact verification |
| **Essay** | Academic sources, philosophical context, supporting arguments, counterpoints |
| **Novel** | Historical accuracy, setting details, technical procedures, cultural context |
| **Memoir** | Timeline verification, historical events, location details, period accuracy |
| **Screenplay** | Visual references, location research, period details, technical accuracy |

### Basic Research

**Command:** `[RS]` Research

Process:
1. Tell Juno what you need to research
2. Juno asks about depth needed (quick/standard/deep)
3. Executes web searches from multiple angles
4. Assigns credibility tiers to sources
5. Cross-references findings for conflicts
6. Saves research notes to `_research/` folder
7. Identifies research gaps and suggests follow-up queries

### Deep Research

**Command:** `[DR]` Deep Research

Automatically uses deep mode (7-15 searches) for comprehensive investigation with multiple angles, expert sources, counterpoints, and cross-referencing. This is the mode Juno offers during Genesis for research-heavy genres.

### Fact Checking

**Command:** `[FC]` Fact Check

Verify claims with confidence scoring:
- **HIGH** — Multiple Tier 1 sources agree
- **MEDIUM** — One Tier 1 or multiple Tier 2 sources
- **LOW** — Only Tier 3 sources
- **NONE** — No sources found

Categorizes claims by type (dates, statistics, quotes, scientific, geographic, cultural, technical, legal). Generates summary statistics. Saves to `_research/fact-checks/`.

### Viewing Research

**Command:** `[SRC]` Sources

View all saved research files, topics covered, and source counts.

### Research Storage

All research is saved to your project's `_research/` folder:
```
my-project/
└── _research/
    ├── topic-name-2025-01-15.md      # Research notes
    ├── another-topic-2025-01-16.md
    └── fact-checks/
        └── chapter-3-2025-01-20.md    # Fact check reports
```

Each research file includes: research question, key findings, detailed notes, source list with URLs and credibility tiers, cross-reference notes, and research gaps.

---

## Voice & Style Features

### Understanding Voice Profiles

Voice profiles capture writing style characteristics across five dimensions:
- **Sentence Architecture** — Length, variance, opening patterns
- **Vocabulary DNA** — Word choice, Latinate vs. Anglo-Saxon ratio, signature words
- **Rhythm Fingerprint** — Cadence, paragraph length, dialogue-to-narration ratio
- **Emotional Palette** — Range, default register, conflict rendering, humor type
- **Imagery & Figurative Language** — Sensory channels, metaphor style, grounding

Profiles are stored in `_bmad/_memory/juno-sidecar/voice-profiles/`

### Managing Voices

**Command:** `[VO]` Voice

Options:
- View current active voice
- List all available voices
- Set a different voice as active
- Adjust profile parameters

### Capturing Author DNA

**Command:** `[CV]` Capture

Process:
1. Provide a text sample (500 words minimum, 2000+ ideal)
2. Juno analyzes across all five dimension categories
3. Extracts quantitative metrics (sentence length, vocabulary breadth, etc.)
4. Rates voice distinctiveness: GENERIC / MODERATE / DISTINCTIVE / UNMISTAKABLE
5. Notes comparison points with known authors
6. Generates and saves voice profile
7. Offers test generation to verify accuracy

**Use cases:**
- Capture your own writing style for consistent generation
- Analyze a favorite author's style for learning
- Create character-specific voices for dialogue

### Blending Voices

**Command:** `[VB]` Blend

Process:
1. Select two existing voice profiles
2. Specify weighting (e.g., 70% Voice A, 30% Voice B)
3. Juno creates a merged profile
4. Saves as new voice profile

**Use cases:**
- Create unique narrator voices
- Blend your style with another author's
- Develop character-specific hybrid voices

---

## Writing Directives

Writing directives are persistent rules that Juno follows whenever generating or editing content. Think of them as your "system prompt" for writing -- formatting mandates, style rules, banned words, and craft instructions that shape everything Juno produces.

### Setting Directives

**Command:** `[WD]` Writing Directives

Options:
- **View** -- Show current active directives
- **Set** -- Replace directives with new rules
- **Edit** -- Modify specific sections or add rules
- **Clear** -- Remove all directives
- **Load Template** -- Choose from pre-built directive templates (see below)
- **Scope** -- Choose global (all projects) or project-level

You can provide directives in any format -- free-form paragraphs, bullet lists, stream-of-consciousness. Juno organizes them into sections while preserving your exact wording.

### Directive Sections

| Section | Purpose | Example |
|---------|---------|---------|
| **Formatting Rules** | Punctuation, structure conventions | "No em dashes. Use periods, commas, colons instead." |
| **Voice & Style** | Prose style mandates, influences | "Write like Bradbury's lyricism crossed with Denis Johnson's rawness." |
| **Banned Words & Phrases** | Words and phrases to never use | "Never use: delicate, gossamer, luminous, void, vestiges" |
| **Hard Rules** | Anti-patterns and craft rules | "No poetic one-liner endings. No characters marveling at the universe." |
| **What I Want Instead** | Positive directives for desired output | "Concrete sensory details. Mundane moments. Subtext over statement." |

### Two Levels

- **Global directives** (`_bmad/_memory/juno-sidecar/writing-directives.md`) -- Apply to everything you write across all projects
- **Project directives** (`{project}/writing-directives.md`) -- Apply only to that project, supplement or override global rules

When both exist, project directives take precedence on conflicts. Non-conflicting rules from both are combined.

### How Directives Are Applied

Directives are loaded **first** in the context-loading sequence -- before voice profiles, outlines, or any other context. They are treated as hard rules. This means:

- `[WR]` Write loads directives before generating any content
- `[SS]` Scene Surgery loads directives before editing
- `[WA]` Write-As follows directives alongside the voice profile
- Directives are loaded at startup so Juno is always aware of them

### Example

A writer pastes rules like this into `[WD]`:

> No em dashes. Write like a human, not a narrator performing good writing. Never use "echoed through," "hung heavy," "a testament to." Give me concrete, ugly, specific sensory details. Surprise me structurally.

Juno organizes this into sections and saves it. From that point forward, every piece of content Juno generates or edits follows those rules exactly.

### Directive Templates

Don't want to write directives from scratch? Juno ships with pre-built templates you can load as a starting point and customize. Access them via `[WD]` > **Load Template**.

| Template | Best For | Rules | Focus |
|----------|----------|-------|-------|
| **Starter Pack** | Any genre | 12 | Lean starting point targeting the most common AI writing patterns -- banned words, show-don't-tell, pacing |
| **Literary Fiction** | Novels, novellas, short stories | 24 | Interiority, subtext, close psychic distance, earned ambiguity, Anglo-Saxon word preference |
| **Genre Thriller** | Thrillers, suspense, crime | 22 | Forward momentum, tight POV, controlled information, physical cost, ticking clocks |
| **Nonfiction / Blog** | Articles, essays, blog posts | 16 | Clarity, authority, conversational voice, no corporate-speak, specific evidence |

**How templates work:**

1. Invoke `[WD]` and choose **Load Template**
2. Pick a template from the list
3. Choose scope: **global** (all projects) or **project-level** (this project only)
4. If you already have directives, choose to **replace** or **merge**
5. Customize with `[WD]` > **Edit** anytime after loading

**When are templates offered?**

- During **Genesis** (`[GS]`) -- when creating a new project, Juno suggests a genre-matched template if you don't have directives set yet
- On **first session** -- if no directives are active, the startup greeting includes a gentle reminder that templates are available
- Anytime via `[WD]` -- you can load, swap, or merge templates whenever you want

Templates live in `_bmad/_memory/juno-sidecar/directive-templates/`. You can add your own `.md` files there and they'll appear in the template list automatically.

---

## Writing Assistance

### Write-For-Me Mode

**Command:** `[WR]` Write

When you want Juno to generate content:

1. Invoke `[WR]`
2. Juno loads context in order: voice profile, scene outline, character profiles, timeline, lore, previous scene ending, relevant research
3. Choose a generation mode:
   - **Scene** — Full narrative with action, dialogue, description, interiority
   - **Dialogue** — Focused dialogue exchange
   - **Description** — Setting, atmosphere, or character description
   - **Action** — Physical action, chase, fight sequence
   - **Internal Monologue** — Character's inner thoughts
   - **Artifact** — In-world document (letter, journal, news article)
4. Juno generates matching your voice, context, and genre format
5. POV consistency is checked before presenting
6. Review and request alternatives if needed

**Genre-aware formatting:**
- Screenplay: Slug lines, action blocks, character cues, indented dialogue
- Poetry: Form-aware line breaks, meter, stanza structure
- Memoir: First person past tense with present-tense reflections
- Blog/Article: Hook, subheadings, scannable structure

### Write with Specific Voice

**Command:** `[WA]` Write-As

Same as `[WR]` but explicitly selects a voice profile:

```
[WA] hemingway-sparse
```

Useful when writing in a character's POV, experimenting with styles, or matching a specific author's voice.

### Scene Surgery

**Command:** `[SS]` Scene Surgery

More surgical than Write mode — micro-editing on a single scene:

**Modes:**
- **Tighten** — Cut unnecessary words, same impact in fewer words
- **Expand** — Add sensory detail, emotional interiority, dialogue beats
- **Restructure** — Reorder the scene's internal beats for better flow
- **POV-Shift** — Rewrite from a different character's perspective
- **Pacing-Adjust** — Speed up or slow down
- **Tone-Shift** — Adjust emotional register while preserving content

Modes can be combined (e.g., "tighten and tone-shift"). Juno presents the operated version alongside the original with rationale for each change.

### Humanizing Content

**Command:** `[HU]` Humanize

Remove AI-sounding patterns from any content. This is **always optional** — Juno will offer it but never force it.

**How It Works with Write Mode:**

When you use `[WR]` to generate content:
1. Juno generates and presents the content
2. You read and review the output
3. Juno asks: *"Would you like me to run this through the humanizer?"*
4. You choose:
   - **Yes** — Juno runs humanizer and shows comparison
   - **No** — Keep as-is
   - **Changes** — Request specific edits instead
   - **Alternatives** — Ask for a different version

**Patterns Addressed:**
- Inflated symbolism and overblown metaphors
- Promotional or marketing-style language
- Vague attributions ("experts say", "many believe")
- Em dash overuse and rule of three patterns
- AI vocabulary words (delve, tapestry, testament, landscape, multifaceted, etc.)
- Negative parallelisms and excessive conjunctive phrases

### Enhancement Questioning

**Command:** `[EN]` Enhance

Juno uses 12 enhancement approaches to deepen any creative element:

1. **Expansion** — "What if this went further, bigger, deeper?"
2. **Inversion** — "What is the opposite, and what does it reveal?"
3. **Temporal Shift** — "What came before this? What happens after?"
4. **Perspective Shift** — "Who else witnesses this? How do they see it differently?"
5. **Emotional Escalation** — "What is the deepest fear? The deepest desire?"
6. **Constraint** — "What if you had to do this in half the space?"
7. **Genre Lens** — "What would this look like in a different genre?"
8. **Sensory Grounding** — "What does this smell, taste, sound like?"
9. **Provocation (Author)** — "What would [specific author] do with this?"
10. **Provocation (Truth)** — "What is this story avoiding saying?"
11. **Stakes Elevation** — "What happens if the character fails?"
12. **Thematic Deepening** — "What larger truth does this illuminate?"

Each approach includes guidance on when to use it (e.g., use Constraint when a scene feels bloated, use Inversion when a character feels one-dimensional).

---

## Story Architecture Tools

These tools help you manage the structural backbone of your story — subplots, foreshadowing, themes, and the relationship between your outline and draft.

### Subplot Weave

**Command:** `[SB]` Subplot Weave

Maps all story threads across your manuscript:

1. Identifies all threads: main plot, subplots, character arcs, thematic threads
2. Maps each thread's presence per chapter using markers: [A]ctive, [D]ormant, [S]etup, [P]ayoff, [R]esolved, [-]Absent
3. Flags problems:
   - Threads dormant for 3+ consecutive chapters (readers forget)
   - Threads that never resolve (abandoned)
   - Chapters with too many active threads (confusion risk)
   - Chapters with only one thread (potential thinness)
4. Identifies convergence points where threads intersect
5. Saves analysis to `03-plot/subplot-weave.md`

**Use when:** Mid-draft to check story thread health, during outline phase to plan distribution, or during editing to find structural issues.

### Foreshadowing Ledger

**Command:** `[FL]` Foreshadowing

Tracks every narrative promise the story makes:

**Setup types:**
- **Chekhov** — Object/detail implying future significance
- **Prophecy** — Statements about future events
- **Dramatic Irony** — Reader knows what characters don't
- **Pattern Break** — Established pattern to be violated
- **Emotional Setup** — Stakes established for later testing

**Status tracking:** PLANTED (awaiting payoff), PAID (delivered), OVERDUE (should have paid off), ABANDONED (no planned payoff), UNEARNED (payoff without setup)

Flags OVERDUE and ABANDONED entries as priorities. Suggests where PLANTED entries might pay off based on your outline. Saves to `03-plot/foreshadowing-ledger.md`.

**Use when:** During or after drafting to track narrative debts, during editing to ensure every setup pays off.

### Theme & Motif Tracker

**Command:** `[TH]` Theme Tracker

Tracks four categories of recurring elements:
- **Themes** — Abstract ideas the story explores
- **Motifs** — Recurring concrete images, objects, phrases
- **Symbols** — Objects carrying specific metaphorical weight
- **Callbacks** — References to earlier scenes or dialogue

Tracks each element's status: PLANTED, GROWING, PAYOFF, ABANDONED. Flags planted seeds without payoffs, payoffs without setups, overused motifs, and themes stated but never dramatized. Saves to `03-plot/theme-motif-tracker.md`.

**Use when:** To ensure thematic coherence, find opportunities to weave in dormant motifs, or verify the story's symbolic layer is working.

### Outline Reconciliation

**Command:** `[OR]` Outline Reconciliation

Compares your planned outline against your actual draft:

**Categories:**
- **FAITHFUL** — Draft follows outline closely
- **ENRICHED** — Draft adds material beyond the outline
- **DIVERGED** — Draft takes a different direction
- **MISSING** — Outlined beats not in the draft
- **EXTRA** — Draft scenes not in any outline

For diverged items, Juno asks whether the departure was intentional and whether the outline or draft should be updated. Can update the outline to match reality (with your confirmation).

**Use when:** After drafting several chapters to catch drift, during editing to ensure nothing was accidentally dropped.

---

## Craft & Analysis Tools

These tools provide deep analysis of your prose quality, pacing, dialogue, and hooks.

### Critique Workshop

**Command:** `[CQ]` Critique

Structured critique through four reader lenses:

| Lens | Focus |
|------|-------|
| **Casual Reader** | Pacing, clarity, entertainment, emotional hooks. Would they keep reading? |
| **Genre Fan** | Genre conventions, trope awareness, freshness. Does it honor the genre? |
| **Literary Editor** | Sentence quality, structure, thematic coherence, originality |
| **Hostile Critic** | Plot holes, thin characters, cliches, logical failures, unearned moments |

For each lens: overall impression, top 3 strengths, top 3 concerns, one actionable suggestion. Issues flagged by multiple lenses are marked as priorities.

**Use when:** After completing a scene or chapter, before phase review, when you want honest feedback.

### Pacing Map

**Command:** `[PM]` Pacing Map

Analyzes scene-by-scene rhythm across four dimensions:
- **Tension** (1-10) — Unresolved conflict and suspense
- **Action Density** (1-10) — Physical movement and event occurrence
- **Emotional Register** — quiet, tense, joyful, sorrowful, chaotic, intimate, foreboding, triumphant, reflective
- **POV Energy** — How active or passive the viewpoint character is

Produces a rhythm profile table, identifies where the story breathes vs. sprints vs. stumbles. Genre-aware (thrillers need higher tension baselines, literary fiction allows more reflective valleys). Saves to `04-outline/pacing-map.md`.

**Use when:** After drafting multiple chapters, during editing to find pacing problems, when something "feels off" but you can't identify why.

### Dialogue Workshop

**Command:** `[DW]` Dialogue Workshop

Five focused analyses:

1. **Voice Distinctness** — Can you tell who's speaking without tags? Builds a mini speech profile per character
2. **Subtext Check** — Surface meaning vs. undercurrent. Flags "on the nose" dialogue
3. **Speaker Swap Test** — If you swap two characters' lines, does it feel wrong? (It should)
4. **Exposition Detection** — Flags info-dumps ("As you know, Bob...")
5. **Rhythm Analysis** — Natural speech patterns, interruptions, trailing off, silence

Offers rewritten alternatives for problematic exchanges.

**Use when:** When dialogue feels flat, when characters sound alike, when scenes are exposition-heavy.

### Hook Analysis

**Command:** `[HK]` Hook Analysis

Evaluates hooks using six criteria (scored 1-5 each):
- **Urgency** — Reason to keep reading right now
- **Curiosity** — Question the reader needs answered
- **Voice** — Writing voice establishes itself
- **Grounding** — Reader can orient (who, where, what)
- **Originality** — Avoids cliched openings
- **Promise** — Signals what kind of story this will be

Analyzes any hook type: opening line, opening page, chapter openers, chapter closers, scene hooks. Ranks all hooks from strongest to weakest. Special attention to the first line and first page.

**Use when:** Before submitting to agents/editors, when your opening feels weak, to strengthen chapter transitions.

---

## Reader Perspective Tools

These tools simulate how different readers would experience your work.

### Beta Reader Simulation

**Command:** `[BR]` Beta Reader

Simulates seven reader types:
- **Teen Reader** — Pace expectations, engagement threshold
- **Genre Purist** — Convention awareness, trope sensitivity
- **Literary Critic** — Prose quality, thematic depth
- **Sensitivity Reader** — Representation awareness
- **Book Club Member** — Discussion-worthy themes and questions
- **Reluctant Reader** — Accessibility, clarity, pull
- **Target Audience** — Based on your project's defined audience

For each: gut reaction, engagement map (where they lean in/drift), questions they'd ask, what they'd tell a friend, likelihood to continue (1-10). Identifies consensus (strong signals) and divergence (audience targeting insights).

**Use when:** Before sharing with real beta readers, to anticipate reception, to check if you're reaching your intended audience.

### Sensitivity Scan

**Command:** `[SN]` Sensitivity

**Note:** This feature is **off by default**. Juno will never proactively run sensitivity scans or suggest them unless you explicitly invoke `[SN]` or enable it in your preferences (`instructions.md` → Content Scanning Preferences).

Flags potential issues across seven categories: stereotypes, representation gaps, cultural accuracy, power dynamics, trauma portrayal, naming concerns, historical sensitivity.

Each issue includes: specific passage, category, explanation framed as reader perception (not accusation), severity (NOTE/CAUTION/FLAG), and suggested alternatives.

**Important:** This is awareness, not censorship. Great literature explores difficult territory with intentionality.

**Use when:** Writing across cultures or identities you don't share, portraying sensitive topics, before publication. Must be explicitly invoked.

### Kill Your Darlings

**Command:** `[KD]` Kill Darlings

Identifies beautiful passages that don't serve the story:

**Categories:**
- **KEEP** — Beautiful and functional
- **TRIM** — Good core, overwritten — suggests tighter version
- **TRANSPLANT** — Beautiful but in the wrong location
- **CUT** — Genuinely doesn't serve the story
- **SAVE** — Cut but preserved in a darlings morgue file

The darling test: Is it well-written AND does it NOT advance plot, reveal character, build world, or serve theme? Beautiful writing that serves the story is never a darling.

**Use when:** During editing, when a chapter feels long, when pacing drags despite good prose.

---

## Progress & Accountability

### Word Count & Goals

**Command:** `[WC]` Word Count

Tracks:
- Total manuscript word count
- Per-chapter word counts
- Progress against goals (daily, weekly, milestone)
- Writing velocity (avg words per session)
- Estimated sessions to next milestone

**Standard milestones:** 10k (foundation), 25k (quarter), 40k (novella), 50k (NaNoWriMo), 60k (short novel), 80k (standard novel), 100k+ (epic). Adjusted for genre.

**Use when:** Regularly during drafting, to set and track goals, to celebrate progress.

### Session Recap

**Command:** `[SR]` Session Recap

Generates end-of-session summary:
- Words written
- Work completed (bulleted list)
- Creative decisions made (with rationale)
- Open questions for next time
- Specific pickup point ("Continue with Chapter 5, Scene 2...")

Appended to Session History in project memory. Makes returning to a project after time away seamless.

**Use when:** End of every writing session, before switching projects, before a break from writing.

### Chapter Summaries

**Command:** `[SM]` Summaries

Auto-generates per-chapter reference:
- One-line summary
- Characters present
- Locations
- Key plot beats
- Emotional arc (reader feeling at start vs. end)
- Word count

Creates both a summary table and prose summaries. Flags chapters that are significantly lighter or heavier than average.

**Use when:** Returning to a project after time away, before continuity checks, as a quick navigation reference.

### Import Existing Work

**Command:** `[IM]` Import

Brings existing manuscripts, drafts, outlines, and reference material into a Juno project — handling format conversion, chapter splitting for large works, and optionally reverse-engineering project structure from imported content.

**What you can import:**

| Content Type | What Happens |
|-------------|-------------|
| **Complete manuscript** (novel, memoir) | Converts to markdown, splits into chapter files in `05-drafts/`, offers Reverse Genesis |
| **Article, essay, short story** | Converts to single markdown file in `05-drafts/` |
| **Outline or notes** | Converts and routes to appropriate folder (`03-plot/`, `04-outline/`, etc.) |
| **Character/world docs** | Converts and places in `02-characters/` or `01-world/` |
| **Research material** | Converts and saves to `_research/` with attribution |

**Supported formats:** DOCX, EPUB, PDF, RTF, ODT, HTML, TXT, Markdown (via Pandoc)

**Chapter splitting:** For large works, the import script auto-detects chapter boundaries using common patterns:
- Markdown headings (`# Chapter Title`)
- Numbered chapters (`Chapter 1`, `Chapter One`, `CHAPTER 1`)
- Part divisions (`Part I`, `PART THREE`)
- Custom patterns you specify

**Reverse Genesis:** After importing a manuscript, Juno offers to read through the content and auto-generate project scaffolding:
- Vision doc from the premise and themes
- Character profiles for every named character
- World/setting documentation
- Plot structure with act breaks
- Scene-by-scene outline

These are skeleton docs for you to review and refine — Juno's analysis is a starting point, not a final word.

**After import, Juno identifies gaps:**
- Missing character profiles for named characters
- Historical or factual claims that could be verified with `[FC]`
- No voice profile — offers to run `[CV]` Capture on the imported text
- Recommends next steps

**Use when:** Bringing an existing manuscript into Juno for the first time, importing research or reference material, starting a Juno project from work already in progress.

**Requirements:** Pandoc (`brew install pandoc`)

---

## Session Continuity & Recovery

### Incremental Saves (Live State)

Juno automatically saves progress after every completed command — not just at session end. The **Live State** block at the top of `project-memory.md` is updated after each task with:

- What was just completed
- Files touched during the session
- Words written
- Creative decisions made
- Open threads
- A specific pickup point for resuming

This means if your session is interrupted (browser crash, timeout, `/compact`), you lose at most the task that was in progress — everything before that is captured.

### Write-Ahead Logging

Before starting heavy commands (`[WR]`, `[SS]`, `[CC]`, `[DR]`, sub-agent spawns), Juno writes what it's about to do into Live State *before* loading files. If the session dies mid-task, the next startup knows exactly what was in progress.

### Session Recap & Archive

**Command:** `[SR]` Session Recap

When you're done for the day (or Juno suggests a break), `[SR]` converts your Live State into a permanent session archive entry, resets Live State for the next session, and stores the full record in `session-archive.md`.

**Command:** `[SA]` Session Archive

Browse past sessions without loading their full content into context. View dates, titles, and summaries — drill into any specific session for full detail.

### Interrupted Session Recovery

If Juno detects a non-idle Live State on startup (meaning the previous session was interrupted), you'll see:

> *"Welcome back. Our last session was interrupted — you were in the middle of [task]. Everything through [last completed] is saved. Shall we pick up from there?"*

### Context Window Management

Long sessions fill the context window. Juno manages this by:

- **Targeted file loading** — reading only the sections needed for the current task, not entire files
- **Gentle reminders** — after 5-6 completed tasks, Juno may suggest saving with `[SR]` and starting fresh
- **Live State persistence** — because state is saved incrementally, starting a fresh session loses nothing

**Tip:** When Juno suggests a break, take it. Fresh sessions start with full context capacity, and your Live State carries everything forward.

### Customization

In `instructions.md`, you can configure:

- **Incremental saves:** `always` (every command) or `major` (only heavy commands)
- **Context health reminders:** how often Juno suggests `[SR]` + fresh session
- **Session archive:** `automatic` or `manual`

---

## Production & Polish Tools

### Compile & Export

**Command:** `[EX]` Export

Assembles draft files into a single manuscript and converts to publishable formats.

**Step 1 — Compile to Markdown:**
- Configurable chapter headings ("Chapter 1", "Chapter One", "I", custom)
- Scene break markers
- Front/back matter placeholders
- Total and per-chapter word counts
- Estimated page count (250 words/page)
- Saves to `{project}/manuscript-{date}.md`

**Step 2 — Convert to Output Format(s):**

Juno will ask which format you want:

| Format | Best For | Notes |
|--------|----------|-------|
| **Markdown** | Working draft, version control | Default — always generated |
| **DOCX** | Agent/publisher submissions | Industry standard for manuscripts |
| **EPUB** | E-readers (Kindle, Kobo, Apple Books) | Includes book typography stylesheet |
| **PDF** | Print proofing, sharing, print-on-demand | 6"x9" trade paperback layout |
| **All** | Generate all three at once | DOCX + EPUB + PDF in one step |

Converted files are saved alongside the manuscript in the project folder.

**Genre variations:**
- Screenplay: Proper formatting with slug lines and dialogue blocks
- Poetry Collection: Poem titles, section breaks, table of contents
- Short Story Collection: Story titles, author notes, TOC
- Blog/Article: Metadata block with title, date, tags, SEO notes

**Use when:** Manuscript is complete or near-complete, preparing for submission, wanting a single-file view, or generating files for e-readers/print.

**Requirements:** Pandoc (installed via `brew install pandoc`). For PDF output, also needs WeasyPrint (`brew install weasyprint`).

### Query Letter & Synopsis

**Command:** `[QR]` Query & Synopsis

Generates six submission materials:
- **Elevator Pitch** — 1-2 sentences for conversations
- **Logline** — [Character] must [goal] or else [stakes], but [obstacle]
- **Back-Cover Blurb** — 150-200 words, hook-forward, no ending revealed
- **Short Synopsis** — 1-2 pages, full plot including ending
- **Long Synopsis** — 3-5 pages, subplots and character arcs
- **Query Letter** — Hook paragraph, book paragraph, bio, comp titles

Saves to `06-editing/submission/` folder. Comp titles are recent, same-genre, and not megahits.

**Use when:** Preparing to submit to agents or publishers, crafting a pitch, writing back-cover copy.

---

## Common Workflows

### Starting a Novel from Scratch

1. `/juno` → Choose **new** → Choose **Novel**
2. Share your seed idea
3. Answer genre-specific and seed-deepening questions
4. Let Juno scaffold your project
5. `[NX]` — Get recommended next step
6. Work through phases with `[RV]` at each gate

### Importing an Existing Manuscript

1. `/juno` → Choose **new** → Choose genre
2. `[IM]` → Provide the file path (e.g., `~/Documents/my-novel.docx`)
3. Juno converts the file and splits it into chapters
4. Review the chapter split — confirm or adjust
5. Accept **Reverse Genesis** — Juno reads your work and builds project docs
6. Review generated character profiles, world docs, plot structure
7. Correct anything Juno got wrong
8. `[CV]` — Capture your writing voice from the imported text
9. `[ST]` — Check status and start working

### Deep Revision Pass

1. `/juno my-novel`
2. `[CC]` — Run continuity check, fix critical issues
3. `[PM]` — Generate pacing map, identify rhythm problems
4. `[DW]` — Workshop dialogue scenes that feel flat
5. `[KD]` — Find darlings to cut or trim
6. `[SS]` — Apply scene surgery to problem scenes
7. `[CQ]` — Get multi-perspective critique on revised chapters

### Preparing for Submission

1. `/juno my-novel`
2. `[EX]` — Compile manuscript and export to DOCX/EPUB/PDF
3. `[HK]` — Analyze your opening (make it strong)
4. `[KD]` — Final darling check
5. `[CQ]` — Full critique workshop
6. `[QR]` — Generate query letter, synopsis, and pitch

### Tracking Story Threads

1. `/juno my-novel`
2. `[SB]` — Map all subplots and threads
3. `[FL]` — Build foreshadowing ledger
4. `[TH]` — Track themes and motifs
5. `[OR]` — Compare outline against actual draft
6. Address any OVERDUE, ABANDONED, or DIVERGED items

### Mid-Draft Health Check

1. `/juno my-novel`
2. `[WC]` — Check word count and velocity
3. `[PM]` — Pacing analysis across drafted chapters
4. `[CC]` — Continuity check
5. `[CQ]` — Critique workshop on recent chapters
6. `[SM]` — Generate chapter summaries for reference
7. `[NX]` — Get recommendation for what to tackle next

### Session Start-to-Finish

1. `/juno my-novel` — Juno orients you
2. `[ST]` — Review status and pickup point
3. Work on your scenes (write, edit, research as needed)
4. `[WC]` — Check progress during or after writing
5. `[SR]` — Generate session recap before ending

### Writing a Scene

1. `/juno my-novel`
2. `[ST]` — Check where you are
3. Navigate to the scene you want to write
4. Option A: Write it yourself with Juno's guidance
5. Option B: `[WR]` — Have Juno write it (choose mode: scene, dialogue, etc.)
6. Review, revise, or `[SS]` for surgical edits

### Capturing Your Writing Style

1. `/juno`
2. `[CV]` — Capture Voice
3. Paste 500-2000+ words of your best writing
4. Juno analyzes across five dimensions with quantitative metrics
5. Review the distinctiveness rating and comparison notes
6. `[VO]` — Set it as active
7. Now `[WR]` generates in your style

### Research-First Writing (Blog, Article, Essay)

1. `/juno` → Choose **new** → **Article** (or Blog Post, Essay)
2. Share your topic — Juno will offer to run Deep Research during Genesis
3. Accept the research gate — Juno runs `[DR]` and saves findings to `_research/`
4. Review research: credibility tiers, source conflicts, research gaps
5. Build your outline informed by real data and expert perspectives
6. `[WR]` — Draft with research at hand, citing sources naturally
7. `[FC]` — Fact Check before publishing (confidence scoring on every claim)
8. `[SRC]` — Review all accumulated research and citations

### Researching for Fiction

1. `/juno my-novel`
2. `[RS]` — Research a specific topic (historical period, location, profession, technology)
3. Review findings — let authentic details inform your world-building
4. `[DR]` — Go deeper on critical topics that shape your story's credibility
5. `[SRC]` — Reference saved research while drafting
6. `[FC]` — Verify any real-world facts mentioned in your fiction

### Talking to Your Characters

**Through Juno:**
1. `/juno my-novel`
2. `[MQ]` — Juno enters Masque mode
3. Specify which character to embody
4. Converse freely with the character
5. Say "surface" to return to Juno
6. Review actor's notes
7. `[AP]` — Approve insights to promote to `02-characters/`

**Standalone (for dedicated sessions):**
1. `/masque Elena` — Go directly to character
2. Converse freely, interview, or run dual-voice
3. Say "surface" for actor's notes
4. Return to Juno later and use `[AP]` to approve

### Deep World-Building Session

1. `/juno my-novel`
2. `[LM]` — Summon Loom
3. Choose what to build: location, culture, magic system, institution
4. Loom guides you through targeted questions
5. Collaborate on the element — Loom traces ripple effects
6. When done, Loom saves to `_staging/loom/`
7. `[AP]` — Review and approve into `01-world/`

### Research and Curate

1. `/juno my-novel`
2. `[RN]` — Summon Raven with a research topic
3. Raven investigates, saves findings to `_staging/raven/`
4. `[AP]` — Approve research into `_knowledge/research/`
5. `[VY]` — Summon Vestry to cross-reference with existing knowledge
6. Vestry catalogs, tags, and identifies gaps
7. Future agents can draw on the curated knowledge base

### Professional Line Editing

1. `/juno my-novel`
2. Draft a chapter with `[WR]` or write it yourself
3. `[TS]` — Summon Thistle to line edit the chapter
4. Choose mode: full edit, tighten, rhythm analysis, or dialogue polish
5. Thistle presents edits alongside originals with rationale
6. `[AP]` — Approve edits to replace originals in `05-drafts/`

### Full Continuity Sweep

1. `/juno my-novel`
2. `[LX]` — Summon Lynx for a full audit
3. Lynx scans characters, timeline, locations, objects, world rules
4. Review findings by severity: CRITICAL → MODERATE → MINOR
5. `[AP]` — Approve audit report into `06-editing/continuity-log.md`
6. Fix issues using the report as your checklist

### Building a Knowledge Base from Scratch

1. `/juno my-novel`
2. `[KB]` — Quick-file any notes, links, or ideas you already have
3. `[RN]` — Summon Raven to research topics your story needs
4. `[AP]` — Approve research into `_knowledge/`
5. `[VY]` — Summon Vestry for a gap analysis
6. Vestry identifies what's missing — deploy Raven for those topics
7. Repeat until your knowledge base is comprehensive

### Getting a Second Opinion

1. `/juno my-project`
2. `[CQ]` — Get critique from four perspectives
3. `[BR]` — Simulate specific reader reactions
4. `[HK]` — Check if your hooks are working
5. Address the consensus issues (flagged by multiple lenses)

### Polishing AI-Generated Content

1. `/juno my-project`
2. `[WR]` — Generate a scene or section
3. **Review the generated content** — read it through
4. Juno asks: *"Would you like me to run the humanizer?"*
5. If yes → Juno shows original vs. humanized comparison
6. `[SS]` — Apply scene surgery for further refinement

---

## Tips & Best Practices

### Project Organization

- **One folder per project** — Keep projects separate for clean context
- **Use descriptive names** — `mystery-novel-paris` not `project1`
- **Don't skip phases** — Trust the process even when eager to write

### Working with Juno

- **Be specific with requests** — "Write the opening of chapter 3 where Elena discovers the letter" works better than "write something"
- **Use status regularly** — `[ST]` keeps you oriented
- **Review before advancing** — `[RV]` catches gaps early
- **End sessions with recap** — `[SR]` makes returning seamless

### Craft Tools

- **Critique before sharing** — Run `[CQ]` before showing work to others
- **Track threads early** — Use `[SB]`, `[FL]`, and `[TH]` during plotting, not just editing
- **Workshop dialogue** — `[DW]` is most valuable for scenes with 3+ speaking characters
- **Test your hooks** — `[HK]` on your opening page is the single highest-value analysis

### Voice Profiles

- **Capture multiple voices** — Your natural voice, plus variations
- **Update profiles** — As your style evolves, re-capture
- **Test before committing** — Ask for sample generation to verify accuracy

### Progress Tracking

- **Set realistic goals** — Use `[WC]` to establish targets you can hit
- **Celebrate milestones** — Juno marks them; let those moments land
- **Track velocity** — Your words-per-session average tells you your real pace

### Living Documentation

- **Trust Juno's memory** — Context carries between sessions
- **Check project-memory.md** — See what Juno remembers
- **Flag open threads** — Juno tracks them for you

### Research Best Practices

- **Research early** — Build your knowledge foundation before drafting
- **Be specific** — "1920s speakeasy operations" beats "prohibition era"
- **Use deep mode for important facts** — Anything readers might verify
- **Fact-check non-fiction** — Always run `[FC]` before publishing articles

### Sub-Agents

- **Summon for focus** -- Use sub-agents when a task needs dedicated attention, not for quick questions
- **Review staging regularly** -- Don't let `_staging/` pile up; use `[AP]` after each agent session
- **Masque for character depth** -- Talk to characters when they feel flat or when you're unsure how they'd react. Use `/masque` for deep sessions, `[MQ]` for quick checks mid-Juno
- **Loom for consequences** -- Use Ripple Effects before committing to major world-building decisions
- **Raven then Vestry** -- Research flows best when Raven finds it and Vestry catalogs it
- **Thistle after drafting** -- Don't summon Thistle mid-draft; finish the chapter, then polish
- **Lynx at milestones** -- Run a full audit after every 3-5 drafted chapters, not after every scene

### Knowledge Base

- **Use `[KB]` in the moment** -- File notes, links, and ideas the instant you find them
- **Don't overthink categorization** -- `[KB]` handles filing; Vestry can reorganize later
- **Run gap analysis periodically** -- Summon Vestry to see what's missing before it becomes a problem
- **Everything goes through the knowledge base** -- If you'll need it again, file it; don't rely on memory

### When You're Stuck

- **Use [SP] Spark** — Random inspiration tailored to your project
- **Use [EN] Enhance** — Deep questioning often unlocks blocks
- **Use [WR] Write** — Sometimes reading generated content sparks ideas
- **Use [NX] Next** — Let Juno suggest what needs attention
- **Use [BR] Beta Reader** — Seeing your work through others' eyes can unstick you

---

## Quick Reference Card

```
ACTIVATE
  /juno              → Resume or select project
  /juno my-novel     → Open specific project

PROJECT
  [GS] Genesis       → New project
  [LP] List          → All projects
  [SW] Switch        → Change project
  [OP] Open          → Open by path
  [ST] Status        → Where am I?

STORY & WORLD
  [EN] Enhance       → Deepen any idea (12 approaches)
  [CS] Cast          → Character overview
  [TL] Timeline      → Story timeline
  [CC] Continuity    → Check consistency
  [SP] Spark         → Random inspiration

RESEARCH & KNOWLEDGE
  [RS] Research      → Investigate a topic
  [DR] Deep Research → Thorough investigation (7-15 searches)
  [FC] Fact Check    → Verify your claims
  [SRC] Sources      → View saved research

STORY ARCHITECTURE
  [SB] Subplot Weave → Map story threads
  [FL] Foreshadowing → Track setups & payoffs
  [TH] Theme Tracker → Motifs, symbols, themes
  [OR] Outline Recon → Plan vs draft comparison

CRAFT & ANALYSIS
  [CQ] Critique      → Multi-lens workshop
  [PM] Pacing Map    → Rhythm & tension profile
  [DW] Dialogue      → Voice & subtext workshop
  [HK] Hook Analysis → Test your openings

READER PERSPECTIVE
  [BR] Beta Reader   → Simulate reader reactions
  [SN] Sensitivity   → Representation awareness (opt-in)
  [KD] Kill Darlings → Find beautiful dead weight

PROGRESS
  [NX] Next          → What should I do?
  [RV] Review        → Phase gatekeeper
  [IM] Import        → Bring in existing work
  [WC] Word Count    → Track goals & velocity
  [SR] Session Recap → End-of-session summary
  [SM] Summaries     → Chapter reference cards

WRITE & PRODUCE
  [WD] Directives    → Set rules or load templates
  [WR] Write         → Generate content (6 modes)
  [WA] Write-As      → Generate in specific voice
  [SS] Scene Surgery → Micro-edit (6 modes)
  [HU] Humanize      → Remove AI patterns
  [EX] Export        → Compile & convert (md/docx/epub/pdf)
  [QR] Query/Synopsis → Submission materials

KNOWLEDGE BASE
  [KB] Knowledge     → Quick-file into knowledge base

SUB-AGENTS
  [RN] Raven         → Research agent
  [TS] Thistle       → Line editor
  [LX] Lynx          → Continuity checker
  [MQ] Masque        → Character embodiment (or /masque standalone)
  [LM] Loom          → World builder
  [VY] Vestry        → Knowledge curator
  [AP] Approve       → Review staged work

VOICE
  [VO] Voice         → Manage profiles
  [CV] Capture       → Extract author DNA
  [VB] Blend         → Merge two voices
```

---

*Juno awaits. The story is ready when you are.*
