# Reel-to-Reel Tape Simulator (Processing + Beads + ControlP5)

This project is a **reel-to-reel tape deck simulator** built with [Processing](https://processing.org/), [Beads](http://www.beadsproject.net/), and [ControlP5](https://sojamo.de/libraries/controlP5/).

It lets you:

- **Play** an audio clip at normal speed
- **Stop** the tape with a smooth slowdown
- **Fast-forward** with pitch-warped, sped-up audio
- **Rewind** with reversed, pitch-warped audio
- Hear **nostalgic click sounds** with every button press

All audio files (music and button clicks) are stored in the `data` folder, following Processing’s standard convention.

---

## Features

- **Tape Transport Controls**
  - `Play` — plays the audio clip at 1.0x speed.
  - `Stop` — stops playback, optionally simulating inertia (slow-down).
  - `Fast-Forward` — increases playback rate and pitch to simulate tape speeding up.
  - `Rewind` — plays audio in reverse with warped pitch.

---

## Requirements

- **Processing** (3.x or 4.x)
- **Beads library** for Processing  
- **ControlP5 library** for Processing

### Installing Libraries

1. Open **Processing**.
2. Go to **Sketch → Import Library… → Add Library…**
3. Search for:
   - `Beads`
   - `ControlP5`
4. Install each library.
