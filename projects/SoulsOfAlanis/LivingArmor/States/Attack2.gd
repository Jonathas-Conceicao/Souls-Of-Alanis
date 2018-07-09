extends 'State.gd'

var vel = Vector2(0, 0)

func enter(host):
	if host.data.getHP() <= 0:
		_state_change("Death")
		return
	host.set_animation("Attack")
	vel.x += 1.5*host.thrust*host.BASE_SPEED
	if host.thrust == -1:
		if not host.flipped:
			host.flipped = true
			host.get_node("Pivot").apply_scale(host.FLIPPING_SCALE)
	else:
		if host.flipped:
			host.flipped = false
			host.get_node("Pivot").apply_scale(host.FLIPPING_SCALE)
	return

func update(host, delta):
	host.velocity = vel
	return

func exit(host):
	return "Walk"

func _on_animation_finished(host, anim_name):
	if anim_name == "Attack":
		host._state_change("Walk")
	return
