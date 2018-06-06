extends 'State.gd'

func enter(host):
	host.set_animation("Moving")
	return

func handle_input(host, event):
	if   event.is_action_pressed("ui_select_weapon_0"):
		return "Swap"
	elif event.is_action_pressed("ui_select_weapon_1"):
		return "Swap"
	elif event.is_action_pressed("ui_select_weapon_2"):
		return "Swap"

	# Handle attack
	if event.is_action_pressed("ui_attack"):
		return "Attack"

	# Handle moviment
	if event.is_action_pressed("ui_up"):
		return "Jump"
	if event.is_action_pressed("ui_leep"):
		return "Leep"
	return

func update(host, delta):
	if   Input.is_action_pressed("ui_right"):
		host.velocity.x = host.BASE_SPEED
	elif Input.is_action_pressed("ui_left"):
		host.velocity.x = -host.BASE_SPEED
	else:
		return "Pop"
	return

func exit(host):
	host.velocity.x = 0
