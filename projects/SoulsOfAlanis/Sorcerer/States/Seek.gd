extends "State.gd"

var right = false

func enter(host):
	host.set_animation("Moving")
	return

func update(host, delta):
	self.update_direction()
	if right:
		host.velocity.x = host.SPEED
	else:
		host.velocity.x = -host.SPEED
	host.velocity.y += host.GRAVITY
	host.velocity.y = max(40, host.velocity.y)
	host.update_flip()
	return

func update_direction():
	right = false
	return
