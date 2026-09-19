---
name: script-to-video-prompts
description: Turn a script or story into paste-ready AI video prompts, split into 10-second clips (or the app's clip length) with timed shots, @ reference tags for character/location consistency, and per-clip negative prompts. Use when the user gives a script, story, episode or scene and wants video generation prompts (Seedance, Kling, Veo, Runway, Sora, Hailuo, etc.).
license: MIT
compatibility: Any Agent Skills-compatible agent (Claude Code, Codex, Gemini CLI, OpenCode, Qwen Code, Cursor, GitHub Copilot). Needs file write access to save the prompt pack.
metadata:
  author: Apoorve Verma
  url: http://apoorveverma.com
  version: "1.1.0"
---

# Script → 10-second video prompts

Converts a script or story into a **prompt pack**: one paste-ready prompt per 10-second clip (SUBJECTS | ENVIRONMENT | STYLE blueprint → timed SHOT lines → negatives). The pack exists for **consistency**: the same characters and places in every clip, so the user can paste each block into a video app and cut the results together.

All creative content comes from the user's current script and tags. The skill carries no story of its own, and its examples are abstract placeholders, never content to reuse. Where the script is silent, add only the minimum **staging** needed to film a beat (a prop set down, a door opened), never a new story event, and list every such choice as an assumption in the delivery. Staging must physically achieve what the script says it is for; when unsure of the mechanism, describe the outcome (`<prop> angled so <result>`).

If the user can't be asked (or doesn't answer), use the step-1 standard defaults for app limits and the most common reading for everything else, and mark each "(assumed)" in the pack header.

## References
- [clip-template.md](references/clip-template.md): output format and all writing rules. Read every run.
- [camera-dictionary.md](references/camera-dictionary.md): camera moves, framing, lenses, transitions. Consult when choosing each shot's camera.
- [negative-library.md](references/negative-library.md): candidate negatives by category. Read every run.
- [sfx-dictionary.md](references/sfx-dictionary.md): sound techniques and libraries. Consult the sections the script's sounds need.
- [lighting-dictionary.md](references/lighting-dictionary.md): time of day, sources, setups, grades. Consult when building lighting states.
- [performance-dictionary.md](references/performance-dictionary.md): voice lock, expressions, delivery. Consult when the script has dialogue or voice-over.
- [platform-notes.md](references/platform-notes.md): when the user names a video app or its limits.
- [reference-sheets.md](references/reference-sheets.md): only when the user asks to create a character or location sheet.

## Steps

### 1. Inputs
Collect from the message. Ask **once**, in one question, only for what is missing or ambiguous:
- **The script or story.** Prose is fine; step 3 converts it.
- **@ reference tags.** The user's own images, named with `@`. Use exactly their names. If none were given, propose one tag per recurring character and location. If some were given but a speaking or recurring character has none, offer to add one. Confirm in the same question:
  - any tag that doesn't obviously match a story name,
  - any character who appears as a variant (younger self, disguise),
  - whether each character ref is a **character sheet** or a **single image** (it changes the template wording),
  - whether a location ref covers every space the script uses there (an interior as well as an exterior).
  Never invent extra reference images for them to make.
- **Aspect ratio.** Default `9:16`.
- **Video app** (optional). If named, apply platform-notes.md. Include in the question any limit the pack depends on that the user hasn't stated: allowed durations, whether it cuts between shots inside one generation, negative box, reference image cap, @ tags vs numbered image slots, prompt length, audio, whether aspect is set in the app's UI. Anything still unconfirmed is marked "(assumed)" in the pack header. **Standard defaults**, used with no app named and for any limit of a named app that the user hasn't confirmed: 10 s multi-shot generations, audio generated, no prompt length limit, @ tags, a separate negative box, `--ar` in STYLE. Never guess a stricter limit from memory; restrictions come only from the user.

Done when: script, tag list with every story name mapped to a tag, reference types, and aspect ratio are settled (by the user or by a default listed as an assumption).

### 2. Asset registry
Map every recurring character, creature, prop and location (recurring = appears in two or more beats) to its @ tag (story name → tag). Flag untagged recurring items as consistency risks, with the one-line description you will reuse for them. An untagged speaking character also gets a short **label** (2–4 words from that description) used in dialogue lines. Identical copies of a prop are registered once, with the count. A character with a separately tagged older or younger self is two characters, each with its own tag and entry. The **main character** is the one who appears in the most beats; on a tie, the first tag the user listed.

Build the locks, each reused unchanged wherever it applies:
- **Voice lock** per character who speaks or has voice-over (performance-dictionary.md).
- **Location lock** per distinct space: one lighting state and one ambience bed (lighting- and sfx-dictionary). One tag covering several spaces gets one lock per space, each named `@<Tag> (<space>)`. A time jump into the same place (flashback, dream, next morning) gets its own lock.
- A lighting state names only light sources fixed to the place, in the condition they are in when the place is **first seen** in the pack. Carried props belong to SUBJECTS. Later script changes to the light go in the clip's shot-scoped changes.

Done when: every character, creature, prop and location is registered, and every speaker and space has its lock.

### 3. Beat sheet and 10-second split
Break the script into **beats**: one visible action, line of dialogue, sound cue, on-screen text or establishing description each. Unvoiced backstory prose (what "everyone knows", history) is not a beat: omit it by default, list it as an assumption, and offer narrator voice-over or a POST TEXT title card in the delivery. Durations:
- **Dialogue line** (one character's continuous speech; a quote interrupted only by attribution is one line, a quote interrupted by an action is two lines): words ÷ 2.5 s. Use words ÷ 2 s when the voice lock's pace is slow or the delivery is slow, deadpan, hesitant or whispered. Add 0.5 s for each written pause (… or —). Minimum 1 s. A line never takes more than its unit's length minus 1 s; if it would, it gets its own unit or a longer allowed duration. If no allowed duration fits, split the line at the last sentence boundary (else clause boundary) that fits, give each part its own unit with the speaker on screen and the same delivery, end the first part on the speaker, mark `line continues` / `line continued` in both edit notes, and list the split as an assumption. This is the only case where a line crosses a unit boundary.
- **Inner thought / voice-over**: runs over action; adds time only when nothing else happens.
- **Action**: 1–3 s; covering distance (crossing a room, climbing stairs) at least 3 s.
- **Establishing description** (a scene heading, a paragraph setting the place): 2 s.
- **Pause**: "a beat" / "silence" 1.5 s; "a long beat" 3 s; a counted pause, its count. Several pause cues in a row count as one pause, the longest.
- **Sound cue**: 0 s when it plays over action; 1 s when it is the only thing happening; its written length when the script says it lasts ("goes on and on": 3 s or more). A sound that a character then reacts to, answers or imitates is its own beat (at least 1 s) placed before the response, never overlapping it.
- **On-screen text**: words ÷ 3 + 1 s; a text beat under 2 s becomes its own 2 s insert sub-shot instead of joining a neighbour.
- **Montage item** (each bullet or line of a montage): its own sub-shot, at least 2 s. In multi-shot apps, montage items may share a unit even across time jumps; each carries its own lock inline (`@<Location> (<time/weather>)`). An item with no stated time or weather keeps the previous item's.
- **Full stops between single words** in a line ("Word. By. Word."): each counts as a written pause.
- **Transitions** (cut to, flashback, back to present): 0 s. **Flash cut**: 0.5–1 s, inside a neighbouring sub-shot. **Cut / smash / fade to black at the end**: an edit note, 0 s in the prompt.
- **Black with dialogue or sound over it**: an edit beat, not a shot. End the unit on the event that causes the black (at most 1 s of darkness in the prompt), write `BLACK <n> s; <speaker> V.O. {"<line>"}` in the edit notes, and count it in the runtime. When the app generates audio, the line may instead ride the unit's last sub-shot.
- **Reactions**: a scripted reaction to a line or action (a glare, a freeze, a look, a turn) starts after that line or action ends, never at the same time.

**Pack at the pack level**, not clip by clip:
1. Lay the beats end to end, rounding each to whole seconds. Group them into **sub-shots**: one location, one main action (a short reaction or line may ride along), one camera setup, at least 2 s. A beat shorter than 2 s joins a neighbour.
2. Group sub-shots into **generation units**: 10 s by default, or the app's allowed duration (platform-notes.md). A unit holds at most 4 sub-shots (at most 3 in a unit of 8 s or less); merge neighbours that share a setup, or move a whole sub-shot to the next unit. A dialogue line or on-screen text window never crosses a unit boundary. Keep a setup and its immediate reaction (a line and the look it causes, a turn and the turn back, a punchline and its held reaction) in the same unit; when the chain can't fit, move the setup into the next unit rather than splitting the chain. A location change or time jump starts a new unit where possible.
3. **Balance:** a unit that overflows pushes whole sub-shots into the next unit; one that underflows lets its beats breathe. Spend slack first on the reaction after a punchline, reveal or decision (a held look of 1–2 s); in suspense, first on the wait before the payoff (each sound cue the characters react to gets at least 1.5 s, and a long silence or long beat right before the climax at least 4 s); then on establishing moments. When a line fills its slot exactly, borrow 0.5–1 s from a neighbouring action beat. Slack may move between neighbouring units. Trim action, never dialogue, never below the action minimums above, and never squeeze a story's climax below the time its beats need.
4. The runtime is the sum of the units plus any black-with-voice edit beats. If the last unit overflows, add a unit rather than cramming. Never add story events to fill time.

Done when: every beat sits in exactly one sub-shot (or one edit beat), every unit is exactly its allowed length, and each unit's sub-shots tile it with no gaps.

### 4. Write every clip
Write each unit with clip-template.md, using camera-dictionary.md for camera and transitions, the dictionaries for sound, light and delivery, and negative-library.md for [CLIP n].

Done when: every unit has an instruction header, SUBJECTS, ENVIRONMENT, the identical STYLE line, all sub-shots, and a NEGATIVE block (or the substitute platform-notes.md prescribes for the user's app), and no template placeholder text remains.

### 5. Audit
Check the pack against the script, top to bottom:
- Every beat, dialogue line (verbatim) and sound cue appears, in order.
- STYLE is character-identical across units. [BASE] is identical except items removed under the no-contradiction rule. Each voice and location lock is identical wherever used, except a field replaced by a whole-unit change.
- Each dialogue line fits its sub-shot at its delivery pace, and no delivery note contradicts its voice lock's pace.
- Timecodes inside every PROMPT block and POST TEXT line are local, from 0:00 to the unit length.
- Each unit's upload list matches the tags inside it, with the main character first whenever on screen, and last (style reference only) when not.
- Every shot obeys the template's face-lock and coherence rules.
- All on-screen text is in POST TEXT, with its surface held still and facing camera for the window.
- Figurative prose has been turned into filmable image and sound. PROMPT blocks contain no "no <noun>", "without <noun>" or "never <verb>", apart from the template's fixed phrases "no face morphing" and "no readable text".
- No [CLIP n] item describes anyone or anything the unit shows, and no block exceeds a known prompt limit.
- Every light, prop and camera position physically produces what its shot says, and matches the direction characters face.
- Every change in effect from a unit's first shot has replaced its lock field.
- Every story detail (event, object, costume, line) traces to the script, the user's tags, or a listed assumption. Sensory fill (implied sounds, light color, framing) stays consistent with the script and the location lock.
- No example wording from the skill's reference files appears in the pack unless the script itself calls for it.

Done when: every check passes; fix and re-check anything that failed.

### 6. Deliver
Write the pack to `<Title_Slug>_Prompts.md` in the current working directory, in this order: header (title, runtime, aspect, app notes and assumed limits), tag table (story name → tag → units), assumptions (tag mappings, reference types, defaults, staging, voice-lock choices, padding), consistency risks, then the units. Reply with the file path, unit count, and the risks and assumptions in a few lines.
