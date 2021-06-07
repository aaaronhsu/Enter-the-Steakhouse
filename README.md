# Enter the Steakhouse

[Link to Planning Document](https://docs.google.com/document/d/11vZPQI7p4fu9-Jm3V2AgnCRwOxf1TOo5luuOlPP4I3o/edit?usp=sharing)

## Group Name: Mooing Steak

## Group Members: Aaron Hsu, Yaying Liang Li

## Description:
*Enter the Steakhouse* is a roguelike bullet-hell dungeon crawler where the player will navigate through various rooms with the goal of finding and defeating the boss of the floor. As the player explores the floor, they will be faced with enemies. Each room may contain a set of enemies that differ in strength and attack patterns that the player must defeat to proceed. Other rooms may contain a shop, where the player can upgrades, or a chest, which can be opened with keys found around the floor. Each floor is procedurally generated.

## Compile/Run Instructions
1. Clone the repository
2. Open the Processing project
3. Press the run button on the top left of Processing

## UML:
![UML](https://github.com/chicknmilk/APCSFinalProject/blob/main/uml.jpeg)


## Devlog:
### 5/24
**Aaron**: Worked on project proposal and created the room generation algorithm using BFS.

**Yaying**: Worked on project proposal.

### 5/25
**Aaron**: Worked on floor traversal. Players can now move between rooms.

**Yaying**: Worked on different Enemies. Different Enemies shoot different styles of projectiles.

### 5/26
**Aaron**: Worked on wall collisions (so that they player can't walk into walls). Corridors are now deleted if there is no adjacent room. Also new maps!

**Yaying**: Added customizable size + color feature to projectiles + fixed shoot-3-projectiles-at-a-time bug. Added collision detection for enemy projectiles.

### 5/27
**Aaron**: Player can now fall (and take damage) into pits. Also added a small GUI for the amount of health.

**Yaying**: Changed projectiles to circles. Created despawning feature when projectile collides with player, or set amount of time passes.

### 5/28
**Aaron**: Merged `map-movement` to main and solved merge conflicts.

**Yaying**: Merged `monster-examples` to main and solved merge conflicts.

### 5/29
**Aaron**: Added player shooting and projectile bouncing.

**Yaying**: Experimented with + added monster designs to our enemies.

### 5/30
**Aaron**: Created random spawning of enemies in rooms. Also merged `interactions` and `enemy-spawning` into main.

**Yaying**: Created collision box for enemies and checked for enemy-player projectile collisions.

### 5/31
**Aaron**: Worked on A* pathfinding for enemies.

**Yaying**: Added boss design!

### 6/1
**Aaron**: Finished A* pathfinding, created barebones for shop room, and rescaled screen size.

**Yaying**: Relearned projectile motion.

### 6/2
**Aaron**: Created functional shop room, made visual changes, map screen toggle, and enemy spawning/attack pattern changes.

**Yaying**: Worked on boss attack pattern 3 (random) and 2 (chase)

### 6/3
**Aaron**: Modified map overlay, added the boss to the boss room, and added a win/loss screen for demo

**Yaying**: Worked on boss attack pattern 3 (random) and 1 (swirl) from Aaron's help.

### 6/4
**Aaron**: Sketched out how the menu pages will look like.

**Yaying**: Added Menu Page with color-changing buttons upon hover.

### 6/5
**Yaying**: Added Map Selection page

### 6/6
**Aaron**: Moved floor generation to menu page.

**Yayiing**: Added cow pixel art; fixed color scheme for map selection page
