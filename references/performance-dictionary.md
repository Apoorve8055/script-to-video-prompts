# Performance & voice dictionary

Vocabulary for expressions, body language and dialogue delivery, plus the **voice lock** that keeps each character sounding the same across clips.

## Voice lock
Every speaking character gets one fixed voice description, used unchanged in every clip where they speak:

`voice (<age>, <gender if stated>, <pitch: low/mid/high>, <texture: smooth/raspy/breathy/bright/gravelly>, <pace: slow/measured/quick>, <accent if stated>)`

It describes sound only, never mood or appearance. Take age and gender from the script; choose pitch, texture and pace to fit the character, and list those choices as assumptions in the delivery so the user can adjust them. Put it in SUBJECTS right after the character's tag, only in clips where they speak. Emotion goes in each line's `(delivery)` note. A younger or older variant gets its own lock. Non-human characters get a lock describing the size and material of the sound.

## Facial expressions (subtle → strong)
neutral, calm, observant, curious, thoughtful, skeptical, amused, faint smile, faint smirk, raised eyebrow, eyes narrowing, frowning, concerned, worried, sad, tearful, surprised, wide-eyed, shocked, fearful, horrified, angry, furious, determined, resolute, relieved, exhausted, disgusted, confused, embarrassed, proud, joyful, laughing

Prefer the subtle end for the main character (see face lock in clip-template.md).

## Body language & action verbs
stands still, freezes, walks, strides, hurries, runs, sprints, stumbles, staggers, crouches, kneels, leans in, steps back, recoils, flinches, turns, glances, looks around, stares, nods, shakes head, shrugs, crosses arms, clenches fist, points, reaches out, grabs, pulls away, touches, places hand on, lowers head, looks up, sighs, trembles, braces, shields face, collapses

## Dialogue delivery notes
whispering, murmuring, quiet, flat, deadpan, dry, sarcastic, casual, warm, gentle, curious, hesitant, nervous, shaky, urgent, firm, commanding, cold, menacing, pleading, excited, bubbly, cheerful, sad, choked up, panicked, shouting, screaming, laughing, breathless, matter-of-fact, official, solemn, amused

## Crowd & background actors
Give crowds one shared behavior per shot (chatting, frozen, turning heads in sequence, parting, fleeing, cheering) so the model keeps them coherent.
