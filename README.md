# Script to Video Prompts

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Version](https://img.shields.io/badge/version-1.1.0-green.svg)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-compatible-orange.svg)](https://agentskills.io)

An [Agent Skill](https://agentskills.io) that turns a script or story into a **paste-ready prompt pack** for AI video generators: one prompt per 10-second clip, with timed shots, `@` reference tags that keep characters and locations consistent, and a negative prompt for every clip.

Writes prompts for **Seedance, Kling, Veo, Runway, Sora, Hailuo** and similar video apps.

Runs in any AI coding agent that supports the open [Agent Skills](https://agentskills.io/specification) standard:

| Agent | Supported |
|---|---|
| Claude Code, Claude.ai, Claude Desktop | ✅ |
| OpenAI Codex | ✅ |
| Gemini CLI | ✅ |
| OpenCode | ✅ |
| Qwen Code | ✅ |
| Cursor, GitHub Copilot and [other compatible agents](https://skills.sh) | ✅ via `npx skills` |

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

### Option 1: `npx skills` (any agent)

The [skills CLI](https://github.com/vercel-labs/skills) detects the agents you have installed and sets the skill up for each one. It needs Node.js.

```bash
npx skills add Apoorve8055/script-to-video-prompts -g
```

Pick specific agents with `-a`:

```bash
npx skills add Apoorve8055/script-to-video-prompts -g -a claude-code -a codex -a gemini-cli -a opencode -a qwen-code
```

Leave out `-g` to install into the current project instead of globally.

### Option 2: Install script (no Node.js needed)

Installs the skill for Claude Code, Codex, Gemini CLI, OpenCode and Qwen Code in one step. Needs `git`.

**macOS / Linux / WSL**

```bash
curl -fsSL https://raw.githubusercontent.com/Apoorve8055/script-to-video-prompts/main/install.sh | bash
```

**Windows (PowerShell)**

```powershell
irm https://raw.githubusercontent.com/Apoorve8055/script-to-video-prompts/main/install.ps1 | iex
```

To choose tools or install into the current project, clone the repo and run the script with options:

```bash
./install.sh claude qwen          # only Claude Code and Qwen Code
./install.sh --project            # into the current project
```

```powershell
.\install.ps1 -Tools claude,qwen
.\install.ps1 -Project
```

Tool names: `claude`, `codex`, `gemini`, `opencode`, `qwen`.

### Option 3: Manual

Clone the repo into the skills folder of your agent:

| Agent | Personal (all projects) | Project |
|---|---|---|
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| Codex | `~/.agents/skills/` or `~/.codex/skills/` | `.agents/skills/` |
| Gemini CLI | `~/.agents/skills/` or `~/.gemini/skills/` | `.agents/skills/` |
| OpenCode | `~/.agents/skills/`, `~/.claude/skills/` or `~/.config/opencode/skills/` | `.agents/skills/` |
| Qwen Code | `~/.qwen/skills/` | `.qwen/skills/` |

For example, `~/.agents/skills/` covers Codex, Gemini CLI and OpenCode at once:

```bash
git clone https://github.com/Apoorve8055/script-to-video-prompts.git ~/.agents/skills/script-to-video-prompts
```

On Windows, `~` is `$env:USERPROFILE`. The folder must be named `script-to-video-prompts`.

### Option 4: Claude.ai and Claude Desktop

1. On this page, click **Code → Download ZIP**.
2. In Claude, open **Settings → Capabilities → Skills**.
3. Click **Upload skill** and select the ZIP file.
4. Make sure the skill is switched on.

> Custom skills on Claude.ai require a paid plan with code execution enabled.

### After installing

Restart your agent. The skill loads automatically when you ask for video prompts. You can also call it directly: `/skills` in Codex, Gemini CLI and Qwen Code lists it, and in Claude Code and Qwen Code you can type `/script-to-video-prompts`.

### Updating

Run the same install command again. With `npx skills`, `npx skills update` updates all installed skills. For a manual install, run `git pull` in the skill folder.

---

## Usage

Give your agent your script and your reference tags, and ask for video prompts:

```text
Turn this script into Kling prompts, 9:16.
References: @Maya (character sheet), @Leo (single image), @Kitchen

INT. KITCHEN - NIGHT
Maya pours coffee. Leo walks in, soaked from the rain.
MAYA: You're late.
LEO: I brought the letter.
```

The agent asks **one** follow-up question if anything important is missing, such as tag mapping, reference type, aspect ratio or app limits. Otherwise it uses sensible defaults and marks each one as *(assumed)*.

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
├── install.sh                       # Installer for macOS / Linux / WSL
├── install.ps1                      # Installer for Windows
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
