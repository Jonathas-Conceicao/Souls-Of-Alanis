extends 'State.gd'

func enter(host):
	host.set_animation("Staggered")
	host.velocity.x = 0
	host.velocity.y = 0
	return

func update(host, delta):
	if host.is_on_ceiling():
		host.velocity.y = max(0, host.velocity.y)
		return "Fall"
	if host.is_on_floor() && host.velocity.y >= 0:
		return "Idle"
	if host.is_on_wall() && host.velocity.x != 0:
		return "Idle"
	host.velocity.y += host.GRAVITY
	return

func exit(host):
	host.velocity.x = 0
	host.velocity.y = 0
	var SSprite = host.get_node("Sword")
	var PSprite = host.get_node("Sprite")
	SSprite.set_modulate(Color(1, 1, 1, 1))
	PSprite.set_modulate(Color(1, 1, 1, 1))
	return
