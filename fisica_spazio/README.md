# Fisica Spazio - Solar System Simulator

A complete 3D solar system simulator developed in Godot 4.4 that allows you to explore and study the orbital physics of celestial bodies.

## 📋 Project Description

**Fisica Spazio** is an accurate physical simulation of the solar system that includes:

- **All planets** of the solar system with their real physical characteristics
- **Main natural satellites** (Moon, satellites of Jupiter, Saturn, Uranus and Neptune)
- **Pluto-Charon system** as a double body
- **Customizable asteroids** with different materials and physical properties
- **Realistic gravitational simulation** between all bodies
- **Interactive interface** for exploration and control
- **Free camera** to navigate in 3D space

## 🚀 Main Features

### Included Celestial Bodies

#### Planets
- **Mercury** - The planet closest to the Sun
- **Venus** - The hottest planet in the solar system
- **Earth** - Our home planet with the Moon
- **Mars** - The red planet
- **Jupiter** - The gas giant with its Galilean satellites
- **Saturn** - The planet with rings and its moons
- **Uranus** - The tilted planet with its satellites
- **Neptune** - The outermost planet with Triton
- **Pluto-Charon System** - The dwarf planet system

#### Natural Satellites
- **Earth**: Moon
- **Jupiter**: Io, Europa, Ganymede, Callisto
- **Saturn**: Titan, Enceladus, Iapetus, Rhea, Dione, Mimas
- **Uranus**: Titania, Oberon, Ariel, Umbriel, Miranda
- **Neptune**: Triton
- **Pluto**: Charon

### Physical Features

#### Gravitational Simulation
- Calculation of gravitational forces between all bodies
- Realistic elliptical orbits with accurate orbital parameters
- Orbital inclinations and precessions
- Adjustable time scale (1 day = 0.05 seconds in simulation)

#### Asteroid System
- **Custom creation** of asteroids
- **Two types of materials**:
  - Iron (density: 7870 kg/m³)
  - Stone (density: 1500 kg/m³)
- **Modifiable parameters**:
  - Asteroid mass
  - Initial velocity
  - Launch direction
- **Orbit visualization** with colored traces
- **Realistic physics** with gravitational influence from other bodies

### User Interface

#### Navigation Controls
- **Camera movement**: W, A, S, D
- **ESC**: Exit menu
- **Click on celestial bodies**: Detailed information

#### Planet Information Menu
- Name of the celestial body
- Type (planet, satellite, star)
- Radius in kilometers
- Distance from main body
- Body mass

#### Asteroid Creator
- Material selection (iron/stone)
- Mass control
- Initial velocity setting
- Real-time asteroid visualization
- Launch asteroid into space

## 🛠️ System Requirements

### Required Software
- **Godot Engine 4.4** (stable version)
- **Operating System**: Windows, macOS, Linux
- **RAM**: Minimum 4GB (recommended 8GB)
- **Graphics Card**: OpenGL 3.3 support or higher

### Dependencies
- **GDScript**: Main scripting language
- **3D Modules** from Godot for rendering
- **Physics system** integrated in Godot

## 📁 Project Structure

```
fisica_spazio/
├── project.godot                 # Main configuration file
├── README.md                     # This file
├── scripts/                      # Project scripts
│   ├── classes/                  # Base classes
│   │   ├── GLOBAL.gd            # Global variables and signals
│   │   ├── celestailBody.gd     # Base class for celestial bodies
│   │   └── asteroid.gd          # Class for asteroids
│   ├── main/                    # Main scripts
│   │   ├── space.gd             # Space and physics management
│   │   ├── interface.gd         # User interface
│   │   └── cam.gd               # Camera control
│   ├── planets/                 # Planet-specific scripts
│   └── stars/                   # Star scripts
├── scenes/                      # 3D Scenes
│   ├── main/
│   │   ├── space.tscn           # Main scene
│   │   ├── interface.tscn       # UI interface
│   │   └── asteroid.tscn        # Asteroid model
│   ├── planets/                 # Planet scenes
│   └── stars/                   # Star scenes
├── materials/                   # 3D textures and materials
├── asteroid/                    # Asteroid models and materials
└── background/                  # Backgrounds and environments
```

## 🎮 How to Open and Use the Project

### Godot Installation

1. **Download Godot 4.4**:
   - Go to [godotengine.org](https://godotengine.org/download)
   - Download version **4.4 Stable**
   - Choose the **Standard** version (Mono/C# not needed)

2. **Install Godot**:
   - **Windows**: Extract the ZIP file and launch `Godot_v4.4-stable_win64.exe`
   - **macOS**: Open the DMG file and drag Godot to Applications folder
   - **Linux**: Make the file executable and launch it from terminal

### Opening the Project

1. **Launch Godot Engine**
2. **Import the project**:
   - Click on "Import"
   - Navigate to the `fisica_spazio/` folder
   - Select the `project.godot` file
   - Click "Import & Edit"

3. **First execution**:
   - Godot will automatically import all assets
   - This process may take several minutes

### Running the Project

1. **In the Godot window**:
   - Click the "Play" button (▶️) in the top bar
   - Or press **F5**
   - Select the main scene if requested: `scenes/main/space.tscn`

2. **Fullscreen mode**:
   - The project automatically starts in fullscreen mode
   - To exit fullscreen mode, modify line 65 in `scripts/main/space.gd`

## 🎯 Usage Guide

### Basic Controls

#### Camera Navigation
- **W**: Forward
- **S**: Backward  
- **A**: Left
- **D**: Right
- **Mouse**: Camera rotation (click and drag)
- **Scroll**: Zoom in/out

#### Menus and Interfaces
- **ESC**: Open/close exit menu
- **Click on a planet**: Display detailed information
- **HUD Interface**: Shows simulated time and camera position

### Exploring Celestial Bodies

1. **Information Display**:
   - Click on any planet or satellite
   - A panel will open with:
     - Body name
     - Type (planet/satellite/star)
     - Radius in km
     - Distance from main body
     - Mass

2. **Space Navigation**:
   - Use WASD controls to move freely
   - Observe realistic planetary orbits
   - Notice different orbital velocities

### Creating and Launching Asteroids

1. **Accessing the Asteroid Menu**:
   - Find the asteroid creation panel in the interface
   - You'll see a 3D preview of the asteroid

2. **Asteroid Configuration**:
   - **Material**: Choose between Iron (denser) or Stone (lighter)
   - **Mass**: Adjust the asteroid's mass
   - **Velocity**: Set initial speed and direction

3. **Launch**:
   - Click "Throw" to launch the asteroid into space
   - Observe how its orbit is influenced by planetary gravity
   - The asteroid will leave a colored trace to visualize its trajectory

### Observing Orbital Physics

1. **Planetary Orbits**:
   - Each planet follows its real elliptical orbit
   - Orbital velocities proportional to distances from the Sun
   - Accurate orbital inclinations

2. **Gravitational Interactions**:
   - Asteroids are influenced by all bodies
   - Possible gravitational assists (gravity assist)
   - Complex orbits due to multiple perturbations

3. **Time Scale**:
   - 1 Earth day = 0.05 seconds in simulation
   - 1 Earth year ≈ 18.25 seconds in simulation
   - Day and year counters in the interface

## 🔧 Customization and Development

### Modifying Physical Parameters

The parameters of celestial bodies can be modified in individual script files:

- **Masses**: Defined in planet classes
- **Orbital distances**: `a` parameters (semi-major axis)
- **Eccentricity**: `e` parameter for elliptical orbits
- **Inclinations**: Orbital inclination parameters

### Adding New Bodies

1. **Create a new scene**: Duplicate an existing planetary scene
2. **Modify the 3D model**: Replace textures and meshes
3. **Update parameters**: Modify mass, radius, orbital parameters
4. **Register the body**: Add the new body in `space.gd`

### Modifying the Interface

The interface is defined in:
- **Scene**: `scenes/main/interface.tscn`
- **Script**: `scripts/main/interface.gd`

You can add new controls, information panels, or measurement tools.

## 🐛 Troubleshooting

### Common Problems

1. **Project won't open**:
   - Verify you have Godot 4.4 (not previous versions)
   - Check that all files are present in the folder

2. **Slow performance**:
   - Reduce graphics quality in Godot settings
   - Close other heavy applications

3. **Asteroids not visible**:
   - Check the set mass (values too small might make them invisible)
   - Verify launch position

4. **Unresponsive controls**:
   - Check that the Godot window has focus
   - Verify input settings in the project

### Debug and Modifications

- **Debug console**: Use `print()` in scripts for debugging
- **Inspector**: Modify parameters in real-time during execution
- **Scene dock**: Analyze node structure

## 📚 Implemented Scientific Concepts

### Orbital Mechanics
- **Kepler's Laws**: Elliptical orbits, constant areal velocity
- **Universal gravitation**: F = G(m₁m₂)/r²
- **Orbital perturbations**: Multiple gravitational influence

### Scale and Proportions
- **1 Godot unit** = 1000 km in space
- **1 mass unit** = 1000 kg
- **Gravitational constant** appropriately scaled

### Real Orbital Parameters
- **Semi-major axes** accurate
- **Orbital periods** proportional
- **Inclinations and eccentricities** realistic

## 👥 Contributions and License

This project was developed for educational and research purposes. 

### Possible Improvements
- Addition of comets with extreme elliptical orbits
- More detailed planetary ring system
- Relativistic effects for orbits very close to the Sun
- Multiple visualization modes (orbits, forces, velocities)

### Resources Used
- **Planetary textures**: Astronomically accurate models and textures
- **Orbital data**: Based on real NASA/JPL orbital parameters
- **3D Models**: Meshes optimized for real-time simulation

---

**Enjoy exploring the solar system!** 🌟🪐🚀

For support or questions, consult the Godot documentation or comments in the source code.
