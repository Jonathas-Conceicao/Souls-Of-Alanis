extends "res://script/Classes/Unique.gd"

var BookshelfID = preload("res://scene/utils/BookshelfID.gd")

# GENERIC
func _on_takeHit(agressor):
	if self.current_state != used && agressor.get_name() == "Player":
		use()
		if self.current_state == state.used:
			var aux = BookshelfID.new()
			agressor.add_child(aux)
			agressor.add_to_Chests(aux)
	return

# disables the Unique
# GENERIC
func use():
	match self.current_state:
		state.unused:
			self.current_state = state.other
			drop()
		state.other:
			self.current_state = state.used
			drop(2)
			self.set_enabled(false)
		_:
			self.current_state = state.used
	return

# drops a random item
func drop(one_in = 1, supress = false):
	var ni = null
	if randi() % 2 == 0:
		ni = SItens[randi() % SItens.size()].new()
	else:
		ni = ItemFactory.generateAny(1)
	pass
	if randi() % one_in == 0:
		var ib = ni.gen_ItemBody()
		ib.scale = Vector2(1/self.scale.x, 1/self.scale.x)
		self.add_child(ib)
		ib.spawn()
	pass
	return

func set_enabled(t = true, supress = false):
	if !t:
		$Sprite.visible = false
	return

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	var aux = BookshelfID.new()
	var auxID = aux.get_uniqueID()
	aux.queue_free()
	return auxID