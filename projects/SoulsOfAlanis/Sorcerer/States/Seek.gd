extends "State.gd"

func enter(host):
	host.set_animation("Moving")
	return

func update(host, delta):
	var hp = host.get_global_position()
	var sp = host.seek.get_global_position()
	if abs(int(hp.x - sp.x)) < 10: return "DeathFromAbove"
	if hp.x < sp.x:
		host.velocity.x = host.SPEED
	else:
		host.velocity.x = -host.SPEED
	host.velocity.y += host.GRAVITY
	host.velocity.y = max(40, host.velocity.y)
	host.update_flip()
	return
