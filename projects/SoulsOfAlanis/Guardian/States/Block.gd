extends 'State.gd'

func enter(host):
	host.set_animation("Block")
	host.velocity.x = 0
	host.velocity.y = 0
	return

func update(host, delta):
	host.velocity.x = 0
	host.velocity.y = 0
	return
