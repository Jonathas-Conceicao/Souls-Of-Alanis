extends 'State.gd'

func enter(host):
	if Input.is_action_just_pressed("ui_up") && host.is_on_floor():
		host.velocity.y = -host.BASE_SPEED
	host.set_animation("Jumping")
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
	if host.is_on_floor() && host.velocity.y >= 0:
		self.exit(host)
		return
	host.velocity.y += host.GRAVITY
	if host.is_on_ceiling() || host.velocity.y >= 0:
		return "Fall"
	return

func exit(host):
	host._state_pop()
	return
