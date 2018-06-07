extends 'State.gd'

func enter(host):
	host.velocity.y = -host.BASE_SPEED/2
	if Input.is_action_pressed("player_leep_right"):
		host.velocity.x = host.BASE_SPEED * 1.5
	else:
		host.velocity.x = -host.BASE_SPEED * 1.5
	# host.update_flip()
	host.set_animation("Jumping")
	return

func update(host, delta):
	if host.is_on_floor() && host.velocity.y >= 0:
		return "Idle"
	# if host.get_slide_count() > 0:
	# 	return "Idle"
	host.velocity.y += host.GRAVITY
	if Input.is_action_pressed("player_leep_right") || Input.is_action_pressed("player_leep_left"):
		if host.energy >= 10:
			host.velocity.y -= 10
			host.energy     -= 10

	if host.is_on_ceiling():
		host.velocity.y = max(0, host.velocity.y)
	return

func exit(host):
	host.energy = host.BASE_ENERGY
	host.velocity.y = max(0, host.velocity.y)
	host.velocity.x = 0
	return
