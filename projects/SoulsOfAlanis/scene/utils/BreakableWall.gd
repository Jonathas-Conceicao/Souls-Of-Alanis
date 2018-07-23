extends "res://script/Classes/Unique.gd"

var BreakableWallID = preload("res://scene/utils/BreakableWallID.gd")

# disables the Unique
# GENERIC
func use():
	debug.printMsg("Implement a \"use\" function", debug.msg_type.err)
	self.enabled(false)
	return

# drops a random item
# GENERIC
func drop():
	debug.printMsg("Implement a \"drop\" function", debug.msg_type.wrn)
	return

# FOR CHESTS - see fchest.tscn
# enabled = false <=> open chest
# enabled = true <=> closed chest

# FOR NPCS
# enabled = false <=> already visited, no NPC on this scene anymore
# enabled = true <=> no visited yet, show NPC on this scene
# GENERIC
func enabled(t = true):
	if !t:
		self.visible = false
	return

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	var aux = BreakableWallID.new()
	var auxID = aux.get_uniqueID()
	aux.queue_free()
	return auxID