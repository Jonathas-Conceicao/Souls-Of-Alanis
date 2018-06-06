extends 'State.gd'

export(float) var BASE_SPEED = 350
const UP = Vector2(0,-1)

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
		move(host, BASE_SPEED)
	elif Input.is_action_pressed("ui_left"):
		move(host, -BASE_SPEED)
	else:
		return "Pop"
	return

func move(host, speed):
	var velocity = Vector2(speed, 0)
	host.move_and_slide(velocity, UP)
	return
