extends Area2D

const ItemFactory = preload("res://script/tools/RandomItemGenerator.gd")

const SItens = [
	preload("res://Items/predefined/StarterSword.gd"),
	preload("res://Items/predefined/StarterArmor.gd")
]


enum state {
	used   = 0,
	unused = 1,
	other  = 2
}

var current_state = state.unused

# called by agressor (player)
# GENERIC
func _on_takeHit(agressor):
	if self.current_state != used && agressor.get_name() == "Player":
		use()
	return

# disables the Unique
# GENERIC
func use(supress = false):
	if !supress:
		debug.printMsg("Implement a \"use\" function", debug.msg_type.wrn)
	self.current_state = state.used
	self.set_enabled(false)
	drop()
	return

# drops a random item
# GENERIC
func drop(supress = false):
	if !supress:
		debug.printMsg("Implement a \"drop\" function", debug.msg_type.wrn)
	var item = ItemFactory.generateAny(1)
	var ib = item.gen_ItemBody()
	self.add_child(ib)
	ib.spawn()
	return

# FOR CHESTS - see fchest.tscn
# enabled = false <=> open chest
# enabled = true <=> closed chest

# FOR NPCS
# enabled = false <=> already visited, no NPC on this scene anymore
# enabled = true <=> no visited yet, show NPC on this scene
# GENERIC
func set_enabled(t = true, supress = false):
	if !supress:
		debug.printMsg("Implement a \"drop\" function", debug.msg_type.wrn)

	if !t:
		self.visible = false
	return

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
# GENERIC
func get_uniqueID():
	debug.printMsg("Implement the \"drop\" function", debug.msg_type.wrn)
	return null

func listNPC():
	return []

func listChests():
	return []