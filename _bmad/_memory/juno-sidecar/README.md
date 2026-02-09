# Juno Sidecar

This folder stores persistent memory for the **Juno** Creative Writing Orchestrator.

## Purpose

Juno uses this sidecar to maintain context across writing sessions, store voice profiles, and remember project state. After BMAD installation, this folder will be accessible at:

```
{project-root}/_bmad/_memory/juno-sidecar/
```

## Files

| File | Purpose |
|------|---------|
| `instructions.md` | Startup protocols, user preferences, custom workflows |
| `project-memory.md` | Current project context, last position, session notes |
| `active-voice-profile.md` | Currently active voice/style configuration |
| `voice-profiles/` | Stored voice profiles (author DNA, custom styles) |

## Voice Profiles

Voice profiles capture writing style characteristics:
- Sentence rhythm and length patterns
- Word choice preferences
- Imagery and metaphor tendencies
- Tone and narrative distance
- Unique quirks and signatures

Profiles can be:
- **Captured** from sample text (author DNA)
- **Custom built** through collaborative definition
- **Blended** from multiple source profiles

## Session Continuity

On each session start, Juno loads:
1. `project-memory.md` — Where you left off
2. `active-voice-profile.md` — Current style settings
3. `instructions.md` — Your preferences and protocols

This enables seamless pickup: *"Welcome back. Last session we explored the antagonist's backstory. The thread awaits."*
