# Lighting, time & color dictionary

Vocabulary for each location's **lighting state** (part of the step-2 location lock). Build it from the script's time of day, weather and light sources: `<time of day>, <weather>, <key light source>, <setup>, <grade/palette>`. The lock stays fixed; script-driven changes go in the clip's "what changes" field. A time jump into the same place gets its own lock.

## Time of day
dawn, sunrise, golden hour, morning, late morning, midday, afternoon, late afternoon, sunset, dusk, blue hour, twilight, night, midnight, pre-dawn

## Weather & atmosphere
clear sky, overcast, cloudy, fog, mist, haze, drizzle, rain, storm, snow, dust, smoke, humid haze, volumetric fog, god rays through haze

## Light sources
sunlight, moonlight, skylight, window light, candlelight, firelight, torchlight, lantern, desk lamp, fluorescent, neon, LED strip, screen glow, streetlight, headlights, spotlight, bioluminescence, supernatural glow, emergency light, flashing alarm light, lightning flash

## Lighting setups
- soft light: diffused, gentle shadows.
- hard light: crisp, sharp shadows.
- high key: bright, low contrast.
- low key: dark, high contrast, deep shadows.
- chiaroscuro: strong light/dark sculpting.
- rim light / backlight: outline glow behind the subject.
- silhouette: subject dark against a bright background.
- side light: half the face lit.
- top light: overhead, shadowed eyes.
- under light: from below, unsettling.
- practical light: sources visible in frame.
- motivated light: light that matches a visible source.
- volumetric light: visible beams in air.
- dappled light: broken through leaves or grilles.
- flicker: unstable pulsing light.
- pulsing: rhythmic glow on and off.

## Color temperature & grade
warm (tungsten, amber), cool (blue, moonlit), neutral daylight, mixed warm/cool, teal and orange, desaturated, muted, high saturation, monochrome, sepia, bleach bypass, pastel, neon noir, film emulation, crushed blacks, lifted blacks, high contrast, low contrast

## Palette formula
The last field of a lighting state: `<dominant tone> with <accent color> accents`, derived from that location and time's mood. The STYLE line never carries a palette.
