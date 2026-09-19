# script-to-video-prompts

A Claude skill that turns a script or story into paste-ready AI video prompts: one prompt per 10-second clip (or your app's clip length), with timed shots, `@` reference tags for character and location consistency, and per-clip negative prompts.

Works with Seedance, Kling, Veo, Runway, Sora, Hailuo and similar video generators.

## Install

Clone into your Claude skills folder:

```bash
git clone https://github.com/Apoorve8055/script-to-video-prompts.git ~/.claude/skills/script-to-video-prompts
```

Then give Claude a script, story, episode or scene and ask for video prompts.

## Contents

- `SKILL.md`: the workflow
- `references/`: clip template, plus camera, lighting, performance and SFX dictionaries, negative-prompt library, platform notes and reference-sheet guidance

## Author

[Apoorve Verma](http://apoorveverma.com)

## License

MIT
