extends 'State.gd'

var readyToLeave = 0

func enter(host):
	host.set_animation("Idle")
	self.readyToLeave = 0
	var collision = host.get_node("Collision")
	var areas = collision.get_overlapping_areas()
	var bodies = collision.get_overlapping_bodies()
	self.call_interaction(host, areas)
	self.call_interaction(host, bodies)
	return

func call_interaction(host, array):
	var sig
	for obj in array:
		if obj.has_method("_on_player_interaction"):
			sig = obj._on_player_interaction(host)
			if sig:
				self.readyToLeave += 1
				obj.connect(sig, self, "_on_obj_finished_interaction")
		if obj.has_method("_get_exit"):
			var x = obj._get_exit()
			host.emit_signal("SceneExit", host, x)
	return

func _on_obj_finished_interaction(obj):
	self.readyToLeave -= 1
	return

func exit(host):
	return

func update(host, delta):
	if readyToLeave == 0:
		return "Idle"
	return
