extends "res://Mushroom2/States/State.gd"

func enter(host):
	host.set_animation("Walk")
	return

func update(host, delta):
	var body = null
	if host.direction == host.DIRECTIONS.RIGHT:
		if !host.ray_right.is_colliding() and host.ray_right_down.is_colliding():
			host.velocity.x = host.BASE_SPEED
		else:
			if host.ray_right.is_colliding():
				body = host.ray_right.get_collider()
				if(body):
					if (body.has_method("_on_takeDamage") && (!(body.has_method("foe")))):
						if body != self && body.has_method("_on_takeDamage"):
							var attack = host.data.genAttack()
							body._on_takeDamage(self, attack)
							host.direction = host.DIRECTIONS.LEFT
					else:
						if (body.get_class() != "Area2D"):
							host.direction = host.DIRECTIONS.LEFT
			else:
				host.direction = host.DIRECTIONS.LEFT

	if host.direction == host.DIRECTIONS.LEFT:
		if !host.ray_left.is_colliding() and host.ray_left_down.is_colliding():
			host.velocity.x = -1 * host.BASE_SPEED
		else:
			if host.ray_left.is_colliding():
				body = host.ray_left.get_collider()
				if(body):
					if (body.has_method("_on_takeDamage") && (!(body.has_method("foe")))):
						if body != self && body.has_method("_on_takeDamage"):
							var attack = host.data.genAttack()
							body._on_takeDamage(self, attack)
							host.direction = host.DIRECTIONS.RIGHT
					else:
						if (body.get_class() != "Area2D"):
							host.direction = host.DIRECTIONS.RIGHT
			else:
				host.direction = host.DIRECTIONS.RIGHT
	return

func exit(host):
	host.velocity.x = 0
	return
