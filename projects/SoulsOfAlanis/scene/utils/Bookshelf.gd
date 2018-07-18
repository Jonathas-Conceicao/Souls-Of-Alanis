extends "res://script/Classes/Unique.gd"

func _on_takeDamage(agressor, attack):
	._on_takeDamage(agressor, attack)
	return

# disables the Unique
func use():
	debug.printMsg("Implement a \"use\" function", debug.msg_type.err)
	self.enabled(false)
	return

# drops a random item
func drop():
	debug.printMsg("Implement a \"drop\" function", debug.msg_type.wrn)
	return

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	return global_ids.unique_ids.breakable_bookshelf