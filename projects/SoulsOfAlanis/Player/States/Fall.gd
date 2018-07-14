extends 'State.gd'

func enter(host):
	host.set_animation("Falling")
	return

func handle_input(host, event):
	# Handle attack
	if event.is_action_pressed("player_attack"):
		return "Attack"

func update(host, delta):
	if   Input.is_action_pressed("player_right"):
		host.velocity.x = host.SPEED
		host.update_flip()
	elif Input.is_action_pressed("player_left"):
		host.velocity.x = -host.SPEED
		host.update_flip()
	else:
		host.velocity.x = 0
	if host.is_on_floor():
		return "Idle"
	host.velocity.y += host.GRAVITY
	return

func exit(host):
	return
