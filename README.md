# Pixel Beast

**Pixel Beast** is a 2D game developed in the Godot Engine. The core gameplay revolves around taking control of powerful mythological beasts from different cultures, utilizing their unique abilities to navigate levels and overcome challenges. 


<img width="1600" height="822" alt="image" src="https://github.com/user-attachments/assets/6a811849-eb92-4642-8547-6145137535da" />


The project is currently configured for a web release via platforms like itch.io.

---

## Features

* **Mythological Transformations:** Play as various powerful beasts drawn from different global cultures, each offering distinct mechanics and playstyles.
* **2D Environment:** Built entirely as a 2D experience within the Godot Engine, focusing on clear visuals and precise physics.
* **Web-Ready:** Designed and optimized to be compiled and played directly in modern web browsers.

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

## Controls

| Action | Key Binding |
| :--- | :--- |
| **Move Left / Right** | `A` / `D` or `Arrow Keys` |
| **Jump** | `Space` / `W` |
| **attack / Interact** | `Enter` / `v`|
| **Pause Menu** | `Escape` |

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
