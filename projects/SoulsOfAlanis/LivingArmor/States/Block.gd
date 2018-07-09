extends 'State.gd'

func enter(host):
	if host.data.getHP() <= 0:
		host._state_change("Death")
		return
	host.set_animation("Block")
	host.velocity.x = 0
	host.velocity.y = 0
	return

func update(host, delta):
	host.velocity.x = 0
	host.velocity.y = 0
	return
