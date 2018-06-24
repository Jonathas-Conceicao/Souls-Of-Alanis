extends 'State.gd'

func enter(host):
	if   Input.is_action_pressed("player_select_weapon_0"):
		host.update_speed(1)
	elif Input.is_action_pressed("player_select_weapon_1"):
		host.update_speed(1.5)
	elif Input.is_action_pressed("player_select_weapon_2"):
		host.update_speed(2)
	return

func update(host, delta):
	return "Idle"
