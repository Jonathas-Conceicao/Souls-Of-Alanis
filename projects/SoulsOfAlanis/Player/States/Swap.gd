extends 'State.gd'

func enter(host):
	var nw
	var ok
	if   Input.is_action_pressed("player_select_weapon_0"):
		nw = host.Weapon.new(1, host.Attack.Thrust, 5)
		ok = host.data.setWeapon(nw)
		if ok:
			print("Weapon Swapped")
			host.update_speed()
		else:
			print("Weapon Swap failed")
	elif Input.is_action_pressed("player_select_weapon_1"):
		nw = host.Weapon.new(5, host.Attack.Slash, 15)
		ok = host.data.setWeapon(nw)
		if ok:
			print("Weapon Swapped")
			host.update_speed()
		else:
			print("Weapon Swap failed")
	elif Input.is_action_pressed("player_select_weapon_2"):
		nw = host.Weapon.new(9, host.Attack.Impact, 25)
		ok = host.data.setWeapon(nw)
		if ok:
			print("Weapon Swapped")
			host.update_speed()
		else:
			print("Weapon Swap failed")
	return

func update(host, delta):
	return "Idle"
