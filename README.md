# PeC-Jogos-Projeto-1  
This is our repository for our Digital Games Course.

## The game

The game we are developing is called **Souls of Alanis**, in this README you will find some information about it.  

The [Storyboard](StoryBoard.md) has most of the games aspects and features that we propose to implement.  

The [Hero's Journey](The_Monomyth.md) has some quick notes about the story structure we followed for the game's Lore.  

Some of our tests and tech demos can be found on the [projects](projects/) folder.  

Through the rest of the file we have some weekly-updated information about the current state of the project.  

## Class notes

Some of the notes and activities done in each class of the curse.

- Class 1:
	- Introduction
	- **Activities**
		- [X] Organize groups
		- [X] Create Github repository
- Class 2:
	- Tech demo
	- **Activities**
		- [X] Choose tools
			- Godot Engine
			- Aseprite
			- Gimp
		- [X] Make a simple "Hello World" project
		- [X] Export to run on another machine
		- [X] Start [storyboard](#story-board-notes)
			- Something about the game
			- Something about one stage of the game
			- Some characters of the game
			- Some of the items of the game
- Class 3:
	- Work on the project
	- **Activities**
		- [X] Present a tech demo
		- [X] Play some music
		- [X] Have a Menu
		- [X] More details for story board
- Class 4:
	- Work on the project
	- **Activities**
		- [X] Tech demo for combat mechanics (Jonathas and Felipe)
		- [X] Tech demo for random map generation (Lucas and Juan)
- Class 6:
	- Work on the storyboard
- Class 7:
	- Storyboard and game presentation

## Topics from talks

Topics discussed in ~some of~ our meetings.

### 13.04.18 - Face-to-face
- some aspects for the __story board__:
- initially we should focus on what we can do, so then we create the lore based on that  
- then the lore will be used to create the game itself  
- aspects of the __game__
- we should have a room of tropheus, where there are _paints_ with images of others games that the group made  
- the initial screen shows how deep is the game save  
- and some aspects about the __player__  
- the facts that she is a warrior facilitate the sketching  
- she can still have some feline aspects  

### 20.04.18 - Face-to-face
- Combat tech demo with collision response is ready  
- Finish a proper tech demo for map generation  
- Maybe merge the two tech demos  
- Make some basic notes for the __story board__  
	- Use the hero's journey  
- Find a good model for the __story board__  

### 27.04.18 - Spiritual
- A dark day.

### 08.05.18 - Online
- Notes to make for next Friday's meeting
	- RPG model
	- Combat model
	- Attributes
	- Equipment's values
	- Metrics
	- Foes
	- Main character
- Class diagram
- Rooms examples
	- Foes
	- NPCs
	- Mini bosses

### 11.05.18 + 12.05.18 Online
#### RPG Model
There are two layers of characteristics that any character has, **attributes** and **power**.  
**Power** are what defines a character's fighting power, they are:
- HP
- Stamina
- Carry load
- Attack and Defense
	- Slash
	- Impact
	- Thrust
- XP gain

**Attributes** are used to calculated the character's **power**:
- Vitality
	- + HP
	- + Slash Defense
	- + Impact Defense
	- + Thrust Defense
- Agility
	- + Stamina
	- + Slash Attack
	- + Thrust Attack
	- + Slash Defense
	- + Thrust Defense
- Strength
	- + Carry load
	- + Impact Attack
	- + Thrust Attack
	- + Slash Defense
	- + Impact Defense
- Wisdom
	- + XP gain

#### Main character:
There is only one combat action, but there are three different type of weapons that the hero can use.
Each of them changes a little bit the game style.
The hero also has access to a specialization tree for each type, to make them more unique.
The weapons type and characteristics:  

|       | Damage | Stamina cost |  Speed |
|:-----:|:------:|:------------:|:------:|
| Sword | Medium |    Medium    | Medium |
|  Axe  |  High  |     High     |  Low   |
| Spear |   Low  |      Low     |  High  |

In total there are three classes of equipment the hero can use.  
1. Weapons - They have base **damage** and **weight**.
2. Armors  - They have base **defense** and **weight**.
3. Rings   - They have only bonus **power**.

On each level the main character gains 1 attribute point and one specialization point, to use for both attributes and weapon specialization.

#### Foes
All creatures have a minimum level for the phase they are.
They have no max level and they level up as the player, but always in a slower scale.
Their attributes are incremented in circle on each level up.
Each game phase has a minimum level for the creatures, a recommended level for the player and a scaling factor of the player's level.  

|        | Minimal Level | Player recommend level | Creature Level Proportion |
|:------:|:-------------:|:----------------------:|:-------------------------:|
| Garden |       1       |            5           |            1/4            |
| Castle |       5       |           10           |            1/3            |
|  Crypt |       10      |           15           |            1/2            |

There are 4 great groups of creatures the player can find, Killers, Tankers, Mini Bosses and Bosses.
Each has different ranges of HP and damage.
The table below shows the average strength of the creatures for a player on the recommended level.  

|              | Killer | Tanker | Mini Boss | Boss |
|:------------:|:------:|:------:|:---------:|:----:|
|    To Kill   |   15   |   25   |     15    |  10  |
| To Be Killed |    1   |    3   |     10    |  25  |

#### Rooms
Each phase of the game is divided in rooms,
rooms have different types and sizes and the map is randomly generated at the start of the playthrough.
A room size is given in multiples of the screen size, and
the rooms can have from 0 to 4 creatures for each unit of size it has.
Each room has some static and some dynamic aspects; static content never change;
dynamic content can change for each generated room.
They are:
- Static:
	- Floor
	- Walls
	- Passage positions
	- Scene objects positions
	- Creature positions
- Dynamics:
	- Which creatures are in each position
	- Which items are in each position
	- Which passages are "open" and where they take you.

### 10.07.18 Online
Notes for Layers and Mask:

|                 | Layer |    Mask    |
|:---------------:|:-----:|:----------:|
|     Scenery     |   0   |      -     |
|      Player     |   1   | 0, 3, 4, 6 |
|      Sword      |   2   |   3, 4, 5  |
|       Foes      |   3   |    0, 1    |
|      Items      |   4   |    0, 1    |
| Items - Special |   5   |    0, 2    |
|       NPCs      |   6   |    0, 1    |
|  Foes - Special |   7   |      1     |

## Activities schedule

Dynamic activities schedule

- Legend
	- Jonathas "Thatox" Conceicao - T
	- Juan "Asaki" Rios - A
	- Lucas Bretana - B
	- Felipe "OneEyedAesir" Gruendemann -  O

- 07/05 - 14/05
	- [X] Decide RPG model
	- [ ] Decide random rooms disposition
	- [X] Decide mobs and items and quantity
	- [X] Decide upgrade system (Main character and foes)
	- [X] Decide items bonus

- 07/05 - 28/05
	- [ ] Main character development => T
	- [ ] Ordinary creatures => O
		- [ ] Garden
		- [ ] Castle
		- [ ] Crypt
	- [ ] Weapons => T
		- [ ] Sword
		- [ ] Spear
		- [ ] Axe
	- [ ] Map generation => A
	- [ ] Rooms => A & B
		- [ ] Screen sized room
		- [ ] Long room
	- [ ] Rooms type => A & B
		- [ ] Basic room
		- [ ] Initial room
		- [ ] Loot room
		- [ ] Hallway room
	- [ ] Main Menu & Esc Menu => B
	- [ ] HUD => A
	- [ ] Alpha 0.1 - 28/05

## Unallocated Jobs
- Inimigos
	- Cavaleiro Guardião
	- Planta
	- Armadura-sem-cabeça
	- Serpente
	- Fantasma
	- Aranha
	- Múmia

- Armas
	- Lança
	- Machado

- Main Menu & Esc Menu

- Main Bosses
	- Fauno
	- Beholder
	- Mago

- Sistema de upgrade
	- Personagem
	- Itens
	- Criaturas

- Itens consumíveis
