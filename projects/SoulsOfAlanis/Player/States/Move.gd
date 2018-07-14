extends 'State.gd'

func enter(host):
	host.set_animation("Moving")
	return

func handle_input(host, event):
	# Handles interactions
	if event.is_action_pressed("player_inventory"):
		return "PlayerMenu"
	if event.is_action_pressed("player_interact"):
		return "Interact"

	# Handle attack
	if event.is_action_pressed("player_attack"):
		return "Attack"

	# Handle moviment
	if event.is_action_pressed("player_jump"):
		return "Jump"
	if event.is_action_pressed("player_leep_right") || event.is_action_pressed("player_leep_left"):
		return "Leep"
	return

func update(host, delta):
	if !host.is_on_floor():
		return "Fall"
	if   Input.is_action_pressed("player_right"):
		host.velocity.x = host.SPEED
		host.update_flip()
	elif Input.is_action_pressed("player_left"):
		host.velocity.x = -host.SPEED
		host.update_flip()
	else:
		return "Idle"
	return

func exit(host):
	host.velocity.x = 0
	return
