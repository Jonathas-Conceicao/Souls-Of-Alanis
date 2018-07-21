extends 'State.gd'

var ok = true

func enter(host):
	host.set_animation("Attacking")
	ok = host.data.tryAttack()
	host.emit_signal("DataUpdated", host)
	return

func handle_input(host, event):
	if ok:
		if host.is_on_floor() && host.velocity.y >= 0:
			if event.is_action_pressed("player_jump"):
				return "Jump"
			if event.is_action_pressed("player_leep_right") || event.is_action_pressed("player_leep_left"):
				return "Leep"
	return

func update(host, delta):
	if !ok:
		return "Idle"
	if   Input.is_action_pressed("player_right"):
		host.velocity.x = host.SPEED
	elif Input.is_action_pressed("player_left"):
		host.velocity.x = -host.SPEED
	else:
		host.velocity.x = 0
	if host.is_on_floor() && host.velocity.y >= 0:
		host.velocity.y = 40
	else:
		host.velocity.y += host.GRAVITY
	if host.is_on_ceiling():
		host.velocity.y = 0
	return

func _on_animation_finished(host, anim_name):
	return "Idle"

func exit(host):
	var HitBox = host.get_node("Sword/Hitbox/Sword")

	HitBox.disabled = true
	HitBox.visible = false
	return
