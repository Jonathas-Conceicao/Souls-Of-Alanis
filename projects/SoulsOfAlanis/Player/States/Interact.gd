extends 'State.gd'

func enter(host):
	var collision = host.get_node("Collision")
	var areas = collision.get_overlapping_areas()
	var bodies = collision.get_overlapping_bodies()
	self.call_interaction(host, areas)
	self.call_interaction(host, bodies)
	return

func call_interaction(host, array):
	for obj in array:
		if obj.has_method("_on_player_interaction"):
			obj._on_player_interaction(self)
		if obj.has_method("_get_exit"):
			var x = obj._get_exit()
			host.emit_signal("SceneExit", host, x)
	return

func exit(host):
	return

func update(host, delta):
	return "Idle"
