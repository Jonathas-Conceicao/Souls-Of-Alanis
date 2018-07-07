extends 'State.gd'

func enter(host):
	host.set_animation("Idle")
	if host.is_on_floor():
		host.energy = host.BASE_ENERGY
	return

func handle_input(host, event):
	# if   event.is_action_pressed("player_select_weapon_0"):
	# 	return "Swap"
	# elif event.is_action_pressed("player_select_weapon_1"):
	# 	return "Swap"
	# elif event.is_action_pressed("player_select_weapon_2"):
	# 	return "Swap"

	if event.is_action_pressed("player_interact"): # TODO: @Jonathas use propper buttom for PlayerMenu
		return "PlayerMenu"

	# Handle attack
	if event.is_action_pressed("player_attack"):
		return "Attack"

	# Handle moviment
	if event.is_action_pressed("player_right") || event.is_action_pressed("player_left"):
		return "Move"
	if event.is_action_pressed("player_jump"):
		return "Jump"
	if event.is_action_pressed("player_leep_right") || event.is_action_pressed("player_leep_left"):
		return "Leep"
	return

func update(host, delta):
	if !host.is_on_floor():
		return "Jump"
	else:
		host.velocity.y = 40
	if Input.is_action_pressed("player_right") || Input.is_action_pressed("player_left"):
		return "Move"
	return
