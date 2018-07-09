extends 'State.gd'

func enter(host):
	host.set_animation("Walk")
	return

func update(host, delta):
	var body = null
	if host.direction == host.DIRECTIONS.RIGHT:
		if not host.flipped:
			host.flipped = true
			host.get_node("Pivot").apply_scale(host.FLIPPING_SCALE)
		if !host.ray_right.is_colliding() and host.ray_right_down.is_colliding():
			host.velocity.x = host.BASE_SPEED
		else:
			host.direction = host.DIRECTIONS.LEFT

	if host.direction == host.DIRECTIONS.LEFT:
		if host.flipped:
			host.flipped = false
			host.get_node("Pivot").apply_scale(host.FLIPPING_SCALE)
		if !host.ray_left.is_colliding() and host.ray_left_down.is_colliding():
			host.velocity.x = -host.BASE_SPEED
		else:
			host.direction = host.DIRECTIONS.RIGHT

func exit(host):
	host.velocity.x = 0
	return
