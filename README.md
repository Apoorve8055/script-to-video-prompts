# Script to Video Prompts

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Version](https://img.shields.io/badge/version-1.0.0-green.svg)
![Claude Skill](https://img.shields.io/badge/Claude-Skill-orange.svg)

A [Claude Skill](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview) that turns a script or story into a **paste-ready prompt pack** for AI video generators: one prompt per 10-second clip, with timed shots, `@` reference tags that keep characters and locations consistent, and a negative prompt for every clip.

Works with **Seedance, Kling, Veo, Runway, Sora, Hailuo** and similar apps.

---

## Features

- **Clip splitting.** Breaks your script into beats, times them (dialogue, action, pauses, sound cues), and groups them into 10-second generation units, or whatever length your app supports.
- **Consistency across clips.** Maps every recurring character, location and prop to your `@` reference images, and locks voices, lighting and ambience so they stay the same from clip to clip.
- **Timed multi-shot prompts.** Each clip is a SUBJECTS | ENVIRONMENT | STYLE blueprint followed by timecoded SHOT lines with camera, lighting, performance and sound direction.
- **Per-clip negative prompts.** Chosen for what each clip actually shows.
- **Script-faithful.** Dialogue stays verbatim and nothing is added to your story. Any staging needed to film a beat is listed as an assumption.
- **App-aware.** Adapts to your app's clip lengths, reference-image limits, negative-prompt support and prompt length.
- **Built-in audit.** Checks every beat, line and sound cue against the script before delivering.

---

## Installation

### Option 1: Claude Code (recommended)

Install as a **personal skill**, available in every project:

**macOS / Linux / WSL**

```bash
git clone https://github.com/Apoorve8055/script-to-video-prompts.git ~/.claude/skills/script-to-video-prompts
```

**Windows (PowerShell)**

```powershell
git clone https://github.com/Apoorve8055/script-to-video-prompts.git "$env:USERPROFILE\.claude\skills\script-to-video-prompts"
```

Or install as a **project skill**, shared with everyone who works on a repository. Run this from the project root and commit the folder:

```bash
git clone https://github.com/Apoorve8055/script-to-video-prompts.git .claude/skills/script-to-video-prompts
```

Restart Claude Code. The skill loads automatically when you ask for video prompts.

### Option 2: Claude.ai and Claude Desktop

1. On this page, click **Code → Download ZIP**.
2. In Claude, open **Settings → Capabilities → Skills**.
3. Click **Upload skill** and select the ZIP file.
4. Make sure the skill is switched on.

> Custom skills on Claude.ai require a paid plan with code execution enabled.

### Updating

```bash
git -C ~/.claude/skills/script-to-video-prompts pull
```

On Windows, use `"$env:USERPROFILE\.claude\skills\script-to-video-prompts"` as the path. On Claude.ai, download the latest ZIP and upload it again.

---

## Usage

Give Claude your script and your reference tags, and ask for video prompts:

```text
Turn this script into Kling prompts, 9:16.
References: @Maya (character sheet), @Leo (single image), @Kitchen

INT. KITCHEN - NIGHT
Maya pours coffee. Leo walks in, soaked from the rain.
MAYA: You're late.
LEO: I brought the letter.
```

Claude asks **one** follow-up question if anything important is missing, such as tag mapping, reference type, aspect ratio or app limits. Otherwise it uses sensible defaults and marks each one as *(assumed)*.

### Output

The pack is saved as `<Title>_Prompts.md` in your working directory and contains:

| Section | Contents |
|---|---|
| Header | Title, total runtime, aspect ratio, app notes and assumed limits |
| Tag table | Story name → `@` tag → clips it appears in |
| Assumptions | Defaults, staging choices, voice locks and padding |
| Consistency risks | Recurring elements without a reference image |
| Clips | One paste-ready prompt and negative prompt per clip, plus upload list and edit notes |

Paste each clip into your video app, attach the listed reference images, generate, and cut the results together.

---

## Defaults

| Setting | Default |
|---|---|
| Clip length | 10 s, multi-shot |
| Aspect ratio | 9:16 |
| Audio | Generated |
| References | `@` tags |
| Negative prompt | Separate box |

Name your app, or state its limits, to override any of these.

---

## Repository structure

```text
script-to-video-prompts/
├── SKILL.md                         # Workflow: inputs → registry → timing → clips → audit → delivery
├── references/
│   ├── clip-template.md             # Output format and writing rules
│   ├── camera-dictionary.md         # Camera moves, framing, lenses, transitions
│   ├── lighting-dictionary.md       # Time of day, sources, setups, grades
│   ├── performance-dictionary.md    # Voice locks, expressions, delivery
│   ├── sfx-dictionary.md            # Sound techniques and ambience
│   ├── negative-library.md          # Negative prompts by category
│   ├── platform-notes.md            # App-specific limits and adaptations
│   └── reference-sheets.md          # Character and location sheet guidance
├── LICENSE
└── README.md
```

---

## Contributing

Issues and pull requests are welcome, especially platform notes for new video apps and additions to the camera, lighting and sound dictionaries.

1. Fork the repository.
2. Create a branch: `git checkout -b feature/my-change`.
3. Commit your changes and open a pull request.

---

## Author

**Apoorve Verma** · [apoorveverma.com](http://apoorveverma.com) · [GitHub](https://github.com/Apoorve8055)

## License

Released under the [MIT License](LICENSE).
