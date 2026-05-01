# Pixel Beast

**Pixel Beast** is a 2D game developed in the Godot Engine. The core gameplay revolves around taking control of powerful mythological beasts from different cultures, utilizing their unique abilities to navigate levels and overcome challenges.

The project is currently configured for a web release via platforms like itch.io.

<img width="1600" height="822" alt="image" src="https://github.com/user-attachments/assets/6a811849-eb92-4642-8547-6145137535da" />




---

## Features

* **Mythological Transformations:** Play as various powerful beasts drawn from different global cultures, each offering distinct mechanics and playstyles.
* **2D Environment:** Built entirely as a 2D experience within the Godot Engine, focusing on clear visuals and precise physics.
* **Web-Ready:** Designed and optimized to be compiled and played directly in modern web browsers.


## Controls

| Action | Key Binding |
| :--- | :--- |
| **Move Left / Right** | `A` / `D` or `Arrow Keys` |
| **Jump** | `Space` / `W` |
| **attack / Interact** | `Enter` / `v`|
| **Pause Menu** | `Escape` |



## Hero
<img width="1080" height="589" alt="Gemini_Generated_Image_byfj4tbyfj4tbyfj (1) (1)" src="https://github.com/user-attachments/assets/073314cd-bbfe-49e0-947c-037c0805b246" />

## environment
1

<img width="327" height="185" alt="Screenshot 2026-04-19 at 11 41 48 PM" src="https://github.com/user-attachments/assets/3bda5bdb-20fc-4f9b-a42c-bc2303a15718" />
<img width="325" height="183" alt="Screenshot 2026-04-19 at 11 42 01 PM" src="https://github.com/user-attachments/assets/2bcbc3a6-6537-4e15-855a-d02c93de8183" />

<img width="736" height="978" alt="_ (1)" src="https://github.com/user-attachments/assets/d2c43e80-bff6-449e-a4ec-98b9c27bd4e2" />
<img width="580" height="872" alt="Computer Game Landscapes Collection by VectorPot on @creativemarket" src="https://github.com/user-attachments/assets/ec77ad76-377c-4fb2-ad4c-56bdae674299" />
<img width="2730" height="1536" alt="1" src="https://github.com/user-attachments/assets/2eb7d122-e6b9-4304-b544-fbcdbb0551a0" />
<img width="512" height="1000" alt="_ (5)" src="https://github.com/user-attachments/assets/3ea97134-1dfa-4d39-b35f-dd9a8b109a87" />
<img width="607" height="1080" alt="_ (2)" src="https://github.com/user-attachments/assets/652aab6d-b68d-4344-9815-238be2b12f63" />




## enemy
<img width="600" height="2146" alt="WONDERS EX _ game _ 2D Game concept art, 2009 Pixel Art - injae Byun" src="https://github.com/user-attachments/assets/49be80c9-03ca-479f-b170-52bffa40789d" />
<img width="534" height="468" alt="WhatsApp Image 2026-04-29 at 10 37 21 PM" src="https://github.com/user-attachments/assets/23a86bc7-d917-4a6d-9748-2e98b22d34d4" />






## Prerequisites

To run or edit the project from the source code, you will need:
* Godot Engine (Version 4.x recommended)
* Git (for version control)

## Installation and Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/oggythebuilder/Pixel_Beast.git
   ```

2. **Import into Godot:**
   * Open the Godot Project Manager.
   * Click **Import**.
   * Navigate to the folder where you cloned the repository.
   * Select the `project.godot` file and click **Import & Edit**.

3. **Run the Game:**
   * Press `F5` (or the Play button) in the Godot editor to start the main scene.



## Project Structure

A brief overview of the file architecture:

```text
Pixel_Beast/
├── assets/             # Art, audio, and font files
│   ├── audio/          # Sound effects and music
│   └── sprites/        # Spritesheets for beasts and environments
├── scenes/             # Godot scene files (.tscn)
│   ├── beasts/         # Individual scenes for different mythological beasts
│   ├── levels/         # Level maps
│   └── ui/             # Menus and overlays
├── scripts/            # GDScript files (.gd)
│   ├── player/         # Player movement and transformation logic
│   └── enemies/        # Enemy behaviors
└── project.godot       # Main Godot configuration file
```
## Web Deployment (itch.io)

To export the game for your planned web release:
1. In Godot, go to **Project > Export**.
2. Add a **Web** preset.
3. If your game fails to run on the web after uploading, ensure you check the export settings regarding SharedArrayBuffer and threading, as Godot 4 web exports require specific server headers.
4. Click **Export Project** and upload the resulting `.zip` file to your itch.io dashboard.

## Credits

* **Developer:** oggythebuilder
* **Engine:** Godot Engine

## License

Distributed under the MIT License.
