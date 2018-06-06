extends 'State.gd'

func enter(host):
	host.set_animation("Attacking")
	return

func handle_input(host, event):
	if host.is_on_floor() && host.velocity.y >= 0:
		if event.is_action_pressed("ui_up"):
			host.velocity.y = -host.BASE_SPEED
		elif event.is_action_pressed("ui_leep"):
			return # TODO Leep
	return

func update(host, delta):
	if   Input.is_action_pressed("ui_right"):
		host.velocity.x = host.BASE_SPEED
	elif Input.is_action_pressed("ui_left"):
		host.velocity.x = -host.BASE_SPEED
	else:
		host.velocity.x = 0
	host.velocity.y += host.GRAVITY
	if host.is_on_ceiling():
		host.velocity.y = 0
	return

func _on_animation_finished(host, anim_name):
	self.exit(host)
	return

func exit(host):
	host._state_pop()
	return
