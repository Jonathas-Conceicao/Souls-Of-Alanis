extends 'State.gd'

func enter(host):
	host.set_animation("Idle")
	host.velocity.x = 0
	host.velocity.y = 0
	return

func exit(host):
	return "Walk"
