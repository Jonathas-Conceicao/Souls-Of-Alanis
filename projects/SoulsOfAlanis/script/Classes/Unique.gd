extends Node2D

# FOR CHESTS - see fchest.tscn
# enabled = false <=> open chest
# enabled = true <=> closed chest

# FOR NPCS
# enabled = false <=> already visited, no NPC on this scene anymore
# enabled = true <=> no visited yet, show NPC on this scene
func enabled(t = true):
	if !t:
		self.visible = false
	return

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	return null