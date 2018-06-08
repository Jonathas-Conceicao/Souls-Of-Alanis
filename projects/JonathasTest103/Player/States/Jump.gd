extends 'State.gd'

func enter(host):
	if host.is_on_floor():
		host.velocity.y = -host.BASE_SPEED / 2
	host.set_animation("Jumping")
	return

func handle_input(host, event):
	if   event.is_action_pressed("player_select_weapon_0"):
		return "Swap"
	elif event.is_action_pressed("player_select_weapon_1"):
		return "Swap"
	elif event.is_action_pressed("player_select_weapon_2"):
		return "Swap"

	# Handle attack
	if event.is_action_pressed("player_attack"):
		return "Attack"

func update(host, delta):
	host.velocity.y += host.GRAVITY
	if Input.is_action_pressed("player_jump"):
		if host.energy >= 50:
			host.velocity.y -= 50
			host.energy     -= 50
	if   Input.is_action_pressed("player_right"):
		host.velocity.x = host.BASE_SPEED
		host.update_flip()
	elif Input.is_action_pressed("player_left"):
		host.velocity.x = -host.BASE_SPEED
		host.update_flip()
	else:
		host.velocity.x = 0

	if host.is_on_ceiling() || host.velocity.y >= 0:
		host.velocity.y = max(0, host.velocity.y)
		return "Fall"
	if host.is_on_floor() && host.velocity.y >= 0:
		return "Idle"
	return

func exit(host):
	host.energy = host.BASE_ENERGY
	return
