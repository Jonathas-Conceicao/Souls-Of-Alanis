extends "State.gd"

var direction
var bounces

func enter(host):
	self.direction = Left if host.flipped else Right
	self.bounces = 0
	host.set_animation("Moving")
	return

func update(host, delta):
	if direction == Right:
		host.velocity.x = host.SPEED
	else:
		host.velocity.x = -host.SPEED
	host.velocity.y += host.GRAVITY
	host.velocity.y = max(40, host.velocity.y)
	host.update_flip()
	return

func handle_input(host, command):
	match command:
		0: self.direction = Left
		1: self.direction = Right
		2: return "Seek"
		3: return "Destroy"
		_: pass
	self.bounces += 1
	return
