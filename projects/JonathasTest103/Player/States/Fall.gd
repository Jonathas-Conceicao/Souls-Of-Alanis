extends 'State.gd'

func enter(host):
	host.velocity.y = 0
	host.set_animation("Falling")
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

func update(host, delta):
	if   Input.is_action_pressed("ui_right"):
		host.velocity.x = host.BASE_SPEED
	elif Input.is_action_pressed("ui_left"):
		host.velocity.x = -host.BASE_SPEED
	else:
		host.velocity.x = 0
	if host.is_on_floor():
		return "Pop"
	host.velocity.y += host.GRAVITY
	return

func exit(host):
	host.velocity.y = 40
	return
