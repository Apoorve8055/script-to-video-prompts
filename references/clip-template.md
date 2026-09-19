# Clip template and rules

Each generation unit (a 10 s clip, or a shorter unit when the app requires it) is an **instruction header** for the user, outside code blocks, plus two paste blocks: **PROMPT** and **NEGATIVE**. Only text a video model can use goes inside the blocks. Every `<placeholder>` is filled from the current script, the user's tags, or the step-2 locks. Examples in this file are abstract; never copy their wording into a pack.

````markdown
## CLIP <n><unit letter if split>: <TITLE> (<pack m:ss>–<pack m:ss>)

- **Upload in this order:** @<MainCharacter>, @<Other>, @<Location>
- **Edit notes:** in: <transition from previous unit, or "open on picture">; out: <transition to next unit, or "end">
- **POST TEXT:** <local start>–<local end> "<exact text>" on <surface>   ← only if the unit has on-screen text

PROMPT
```
SUBJECTS: [<subject entry> | <subject entry>]
| ENVIRONMENT: [<environment entry>]
| VOICES: [<label or @Tag>: voice (<voice lock>), heard only]   ← only if someone speaks but is never on screen in this unit
| STYLE: [<STYLE LINE>]

SHOT <id> (0:00–0:0x): <framing>, <lens>mm, </move> / <action> / SFX: <sounds in this shot>.
-> @<Tag> says (<delivery>) {"<exact line>"}

SHOT <id> (0:0x–0:10): <framing>, <lens>mm, </move> / <action> / SFX: <sounds in this shot>.
-> @<Tag> thinks (internal voice-over, <delivery>) {"<exact line>"}
-> <3–6 visual keywords for the whole unit>
```

NEGATIVE (paste into the app's negative box; apps without one: see platform-notes.md)
```
<[BASE] list>, <[CLIP n] items>
```
````

**Timecodes:** the header shows pack time. Everything inside the blocks and the POST TEXT line uses **local time**, from 0:00 to the unit's length.

## Reference wording
The template phrases say "character sheet close-up panels", "character sheet" and "the sheet". If the user's reference for that character is a single image, replace every one of them with "reference image" in SUBJECTS and in the STYLE line. Everything else in the phrases stays unchanged.

## SUBJECTS

One entry per character on screen in this unit, separated by `|`. People are named only by their @Tag. Choose each character's entry by the **most revealing view they get anywhere in the unit**:
- **Face visible at medium or tighter, or large in the foreground, anywhere in the unit** (always the entry for the main character when their face is on screen at all): `@<Tag>, face copied EXACTLY from the @<Tag> character sheet close-up panels (same eyes, eyebrows, nose, lips, jawline, skin tone, hairstyle), SAME person in every shot, exact outfit as in the sheet, <state>`
- **Seen only from behind or in silhouette:** `@<Tag> seen from behind, face not visible, same hair, build and outfit as the sheet, <state>`
- **Only hands or another body part visible:** `@<Tag> (hands only), exact skin tone and sleeves as in the sheet, <state>`
- **Other framings (wide, distant):** `@<Tag>, exact design as in the @<Tag> reference, <state>`
- **Animal or creature** (face visible): `@<Tag>, exact species, markings, colors and proportions copied EXACTLY from the @<Tag> reference, SAME animal in every shot, <state>`
- **Variant sharing the tag** (younger, older, disguised): the face-copy entry, plus `as their younger self (about <age>)`, with "exact outfit as in the sheet" replaced by "outfit in the style of the sheet" unless the script says the outfit is unchanged. If the script gives no visible difference, add one era cue in the prompt and list it as an assumption. A variant with its own tag uses the normal entries for that tag.
- **Untagged character:** the registry's one-line description, word-for-word every time. In dialogue lines use their label: `-> <label> says (…)`.
- **Crowd or extras:** one entry per group, `crowd: <who>, <one shared behavior>`.
- **Speaking or voice-over in this unit:** add `voice (<voice lock>)` right after the tag. Leave the voice out for characters silent in this unit.
- **Script costume the reference may not show:** replace every outfit phrase ("exact outfit as in the sheet", "outfit as the sheet", "sleeves as in the sheet") with `wearing <script costume>` in every unit for that character. Give each costume item with no script color one chosen color, listed as an assumption. The face-copy words stay unchanged.
- **Story-critical detail from the script** (a carried or attached prop): add `holding / with <detail>`, even for tagged characters.
- **Untagged recurring prop handled by a character:** add it to that character's entry with the registry's one-line description, word-for-word.
- `<state>` = expression, pose, condition that holds for the whole unit. A one-shot action goes only in its SHOT line; a state that changes is written `<A>, then <B>`.
- A character who speaks in this unit but is never on screen in it (narrator, unseen voice) goes in VOICES, never in SUBJECTS. Their lines use `-> <label> says (off-camera, <delivery>) {"…"}`. Only an unseen speaker who exists inside the scene gets a [CLIP n] item, with a descriptor no on-screen subject shares; a narrator gets none. Voice-only speakers need no reference tag.

## ENVIRONMENT

- One space: `@<Location>, exact layout as in reference, set: <fixed set details from the script>, <lighting state>, ambience: <ambience bed>, <changes>`
- A space within a multi-space tag: `@<Location> (<space>)` with the same fields.
- Several spaces in one unit: `@<A> (shots <ids>): <fields>; @<B> (shots <ids>): <fields>`.
- Untagged space: a short description in place of the tag. If the script describes nothing, use the minimum the action needs and list it as an assumption. Flag it as a consistency risk.
- `set:` lists fixed details the script gives for the place (furniture, structures, signs, untagged props that stay put). Omit it when the script gives none.
- Lighting state and ambience bed are the location lock, copied unchanged.
- `<changes>` start at a named shot: `from shot <id>: <what is different>`.
- If a change is in effect from the unit's first shot, write the changed value in place of the lock field it contradicts, never both.

## STYLE line

Identical in every unit of the pack:

```
Rendering style matching the @<MainCharacter> character sheet exactly, cinematic lighting, deep controlled shadows, characters and buildings strictly matching reference images, identical face in every shot, stable facial structure, no face morphing, --ar <aspect> --hd
```

Color palette and grade live in each location's lighting state, never here.

## SHOT lines

- `SHOT <id> (<local start>–<local end>): <framing>, <lens>mm, </move> / <action> / SFX: <sounds>.` Shot ids are `<clip number><letter>` (3A, 3B). Framing is plain words (wide shot, medium close-up, over the shoulder). Camera moves and focus effects use the slash prefix (/push in, /rack focus) by default; when the user's app is known not to read slash commands, write them as plain words (slow push in) in every unit. Both come from camera-dictionary.md.
- A sub-shot with nothing visible (darkness) has no framing or lens.
- Cuts between sub-shots are implied. Write a transition inside the block only when it is visible or audible within the unit (flash cut, hard audio cut to silence). Transitions at a unit's start or end, and cuts or fades to black, go in the edit notes only; the PROMPT ends on the last picture.
- **Coherence:**
  - One lens and one starting framing per shot. A move changes the framing by one step at most (wide → medium, medium → close-up).
  - The move and viewpoint agree: "from behind" pairs with /tracking shot, not /side tracking.
  - Adjacent sub-shots differ by at least one framing step or a clear change of angle. If two beats in a row would share a setup, merge them into one sub-shot.
  - A wide that needs the main character's reaction cuts to a new, closer sub-shot for it.
  - When a beat depends on what a device or character can see, include one sub-shot from that viewpoint (pov, or through <device>) if the unit has room.
  - Over-the-shoulder and from-behind shots match the direction the character faces at the end of the previous sub-shot. An over-the-shoulder toward <X> needs the character facing <X>; otherwise use a separate shot of <X>, or add the turn to the action.
- **Filmable text:** describe literal image and sound. Turn metaphors and similes into the literal image and sound they imply. Only dialogue stays verbatim.
- **Absence:** inside PROMPT, never name a thing in order to say it is absent. Describe what the camera sees instead (`bare flat <surface>`, `dark unlit <fixture>`) and put the absent thing in NEGATIVE.
- **Dialogue:**
  - Spoken: `-> @Tag says (delivery) {"exact words"}`. A quote interrupted by attribution is one line: join its parts with a space, and if the first part ends in a comma only because attribution followed, make it a period (keep ? or ! as written). A quote interrupted by an action is two lines, in two sub-shots or with the action between them.
  - The delivery note never contradicts the voice lock's pace; to slow a quick speaker for one line, write "slower than usual".
  - Inner thoughts: `-> @Tag thinks (internal voice-over, delivery) {"…"}`.
  - Off-screen, or face hidden while speaking: `-> @Tag says (off-camera, from <direction or place>, delivery) {"…"}`.
  - Voice-over from a character who is on screen elsewhere in the pack: `-> @Tag says (voice-over, delivery) {"…"}`; it may run across consecutive shots in one unit.
  - When a line and another timed event share a sub-shot, pin each with `at 0:0x` in script order.
  - Heard but unintelligible speech: an SFX item, not a dialogue line.
- **SFX:**
  - Sounds that happen in this shot, as present-tense nouns ("<X> <verb>s" → "<X> <verb>"), ordered hard FX → foley → music.
  - The ambience bed is in ENVIRONMENT; repeat it only when it changes.
  - Implied sounds of visible actions are fine. `SFX: none` is fine.
  - A sound whose source is off-screen or hidden appears in SFX only, as the sound, never as an object in the action.
  - When order inside a shot matters, join sounds with "then" (`SFX: <sound A>, then <sound B>`).
  - A sound that continues from the previous unit starts this unit's first SFX as `continuing <sound>`, with a sound bridge in the edit notes.
- **Keywords line:** one `-> <keywords>` line per unit, after the last shot: the unit's dominant visual in 3–6 words.

## Face lock

- The main character's tag is the first upload in every unit where they are on screen. In a unit without them, their sheet is uploaded last as the STYLE reference only; they stay out of SUBJECTS, and [CLIP n] gets `an extra <main character's short description> in frame`.
- The main character in a wide (wide or full-shot framing, whatever the lens) is shown from behind, over the shoulder, in silhouette, or small in frame (face under 1/10 of frame height). Pick what the scene's geography allows; the camera never sits inside a wall, door or object the script places behind them. Reactions get their own closer sub-shot.
- Close shots keep the face at least 1/6 of the frame height. Any readable face is at a front or 3/4 angle, never in profile: close two-shots are angled 3/4 to camera, and /side tracking on a readable face becomes a 3/4 forward tracking shot. A close over-the-shoulder shot counts as a close shot for the character facing camera.
- /whip pan, /shaky cam, /crash zoom, /fisheye, /roll and heavy /handheld stay off faces; put that motion on the environment.
- Expressions stay subtle and readable, unless the script names a big one (a glare, a forced grin): then state exactly that expression, nothing more extreme.
- Silhouette or motion blur only for flash cuts under 1 s. Flashback and time-jump scenes show faces normally, with the variant cue.
- Pack header note for the user: skip last-frame chaining; regenerate only the unit whose face drifted.

## Text in post

Video models misspell text. Every on-screen text, and every repeat appearance of it, gets its own window in the header's POST TEXT line as `<local start>–<local end> "<exact text>" on <surface>`. In the prompt, the surface holds still and faces the camera for that whole window and shows `blank placeholder lines, no readable text`. Any motion of that surface the script asks for happens before or after the window, or is carried by sound alone.

## NEGATIVE

One line: the [BASE] list, then this unit's items, as plain comma-separated noun phrases of unwanted things.

[BASE], identical in every unit:

```
morphing face, different person, face drift between shots, changing face shape, changing eye shape, changing nose, asymmetric eyes, distorted mouth, changing hairstyle, changing outfit, extra fingers, deformed hands, extra limbs, duplicate characters, warped architecture, buildings changing shape between shots, readable text, garbled text, subtitles, watermark, logo, frame flicker, jitter, style change mid-clip, low resolution, blurry face, wrong voice, voice changing between clips, extra dialogue not in script
```

- **No contradiction beats identity.** If a unit deliberately shows what a BASE item names (flicker, shaking, look-alike characters, a changed outfit), delete that item from that unit's NEGATIVE only. Every other BASE item stays identical.
- Append to [BASE] only a continuity detail that is on screen in every unit.

[CLIP n], 6–15 items from negative-library.md or written for the scene, in this order:
1. The 2–3 likeliest ways the model gets this unit's key beat wrong.
2. Continuity items for props and costumes on screen: `<prop> in the wrong hand`, `<costume> in another color`, `<attached prop> detached`.
3. Wrong time of day, lighting or layout versus this unit's location lock.
4. Tone or audio items only when this unit's content makes them likely.

Rules for [CLIP n]:
- **Never list as unwanted anything the unit intends to show, in its intended state.** A wrong variant of a shown thing is fine (`<prop> in the wrong hand`). A hidden sound's source may appear as `visible <source>`.
- No item may also describe anyone or anything on screen. Use a descriptor no on-screen subject shares (`an extra person in the <space>`, `<distinctive costume> <role> <wrong state>`), or move the item into the SHOT line as the intended state.
- The NEGATIVE applies to the whole generation: leave out any state the unit shows in some shot (open/closed, moving/still, held/set down) and any sound category containing a sound the unit plays. Put that timing in the SHOT lines instead.
- The expression or tone the script asks for is never negated (a comedy takes no "comedic tone").
- Phrase the unwanted thing positively (`<item> in another color`, never `<item> not <color>`).
- No @tags or shot IDs.

## Length

Keep blocks lean: state each lock once, and list per-shot SFX only for sounds that happen in that shot. Never ship a block over a known prompt limit; platform-notes.md has the trim order, and if trimming isn't enough, split the unit into shorter units.
