# GodotGame
Prerequisites:
Python 2.7+/3.5+
Scons
Godot build files

To run the game:
Add the folders outside ForestFiasco to the modules in the Godot Game Build folder

To build the game:
Open Developer Command Prompt for VS
Change directory to the godot-master
Note: It is recommended that you install pywin32 for a faster build
- To install pywin32, run "pip install pywin32"
- If pywin32 is installed run the command "scons -j6 platform=windows"
If pywin32 is not installed, run the command "scons platform=windows"
