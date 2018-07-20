extends 'State.gd'

func enter(host):
	if host.is_on_floor():
		host.velocity.y = -host.SPEED / 2
	host.set_animation("Jumping")
	return

func handle_input(host, event):
	# Handle interaction
	if event.is_action_pressed("player_interact"):
		return "Interact"

	# Handle attack
	if event.is_action_pressed("player_attack"):
		return "Attack"

func update(host, delta):
	host.velocity.y += host.GRAVITY
	if Input.is_action_pressed("player_jump"):
		if host.energy >= 20:
			host.velocity.y -= 23
			host.energy     -= 20
			host.velocity.y -= host.GRAVITY
			host.emit_signal("DataUpdated", host)
	if   Input.is_action_pressed("player_right"):
		host.velocity.x = host.SPEED
		host.update_flip()
	elif Input.is_action_pressed("player_left"):
		host.velocity.x = -host.SPEED
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
	return
