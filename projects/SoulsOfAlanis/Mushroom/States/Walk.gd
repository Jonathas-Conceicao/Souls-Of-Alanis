extends "res://Mushroom/States/State.gd"

func enter(host):
	host.set_animation("Walk")
	return

func update(host, delta):
	var body = null
	if host.direction == host.DIRECTIONS.RIGHT:
		if !host.ray_right.is_colliding() and host.ray_right_down.is_colliding():
			host.velocity.x = host.BASE_SPEED
		else:
			host.direction = host.DIRECTIONS.LEFT

	if host.direction == host.DIRECTIONS.LEFT:
		if !host.ray_left.is_colliding() and host.ray_left_down.is_colliding():
			host.velocity.x = -host.BASE_SPEED
		else:
			host.direction = host.DIRECTIONS.RIGHT
	return

func exit(host):
	host.velocity.x = 0
	return
