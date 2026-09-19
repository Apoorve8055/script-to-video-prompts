# Adapting the pack to the user's video app

Use when the user names their app or its limits. Use the limits the user states; ask in the step-1 question for any the pack depends on; mark anything unconfirmed "(assumed)" in the pack header.

## Duration and cuts
- Units are built in SKILL.md step 3 at the app's allowed duration: 10 s when allowed, otherwise the longest allowed duration that fits the beats (a shorter allowed duration is fine for a unit that needs less).
- **Single-shot apps** (user-confirmed; one continuous shot per generation, no internal cuts): a unit is one continuous setup with at most one camera move, and may hold several timed actions (`at 0:0x`) inside its single SHOT line. Combine consecutive beats that share a place and setup into one unit; give a short beat (an insert) the shortest allowed duration and hold its image for the rest. Time jumps, weather changes and location changes always start a new unit, including in montages.
- Each unit uses clip-template.md's format with its own header, PROMPT and NEGATIVE, headed `## CLIP <n>: <TITLE> (<pack time>)`.

## References
- **@ tags supported:** keep them.
- **Numbered image slots** (Image 1, Image 2 …): order slots main character, then location, then other characters, so the most-used references keep the same number in every unit. Each unit's header maps its slots and flags in bold any number that differs from the previous unit. Inside the PROMPT, write `Image N (<short label>)` wherever the template has an @Tag. Upload only the references that unit uses.
- **Upload order with @ tags:** main character, other characters by screen time, then locations. **Reference cap:** drop the characters with the least screen time in that unit first, then extra locations; list what was dropped in the header.

## Prompt syntax
- **Slash camera tokens:** follow clip-template.md (slash by default, plain words in every unit when the app is known not to read them).
- **Aspect ratio set in the app's UI:** tell the user where to set it and drop `--ar`/`--hd` from STYLE in every unit, so STYLE stays identical.
- **Prompt length limit:** trim in this order until the block fits: [CLIP] negatives, SFX, keywords line, `set:` details, secondary characters' face-copy wording (to the "exact design" entry), action adjectives. Keep dialogue, the main character's face-copy phrase and the locks. If it still doesn't fit, split the unit.

## Negatives
- **Separate negative box:** paste the NEGATIVE block there.
- **No negative box (negative phrasing supported, or not stated):** put a short line at the end of the PROMPT block: `Avoid: <3–6 highest-value [CLIP n] items>, morphing face, different person, deformed hands, garbled text, subtitles, watermark`, plus `extra dialogue not in script, voice changing between clips` when the app generates audio, plus `changing outfit` when a costume is story-critical and unchanged in that unit. This line replaces [BASE] for the whole pack and is identical in every unit apart from its [CLIP n] items.
- **No negative box, and the user says negative phrasing isn't supported:** write no Avoid line (every noun in a prompt is also a cue). Restate the unit's top 2–3 [CLIP n] items as the intended state in the SHOT lines (`<subject> <exact intended state>`).

## Audio
- **No audio generation** (user-confirmed): omit voice locks, VOICES, ambience beds and SFX. Replace each dialogue line with a visible speaking cue in the SHOT line (`@Tag speaks, <delivery>`, or `<label> speaks` for untagged characters) and keep the verbatim lines, with their local timecodes, in the header's edit notes. A story-critical sound gets its visible cause or reaction in the SHOT line.
- **Weak lip-sync:** frame speaking shots so the main character's mouth isn't the focus (3/4, over the shoulder), and suggest adding voices in the edit.

## Start images
- **Image-to-video only:** make one start image per unit from its first SHOT line plus the references, approve the face, then animate.
