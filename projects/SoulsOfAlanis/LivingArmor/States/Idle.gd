extends 'State.gd'

func enter(host):
	if host.data.getHP() <= 0:
		host._state_change("Death")
		return
	host.set_animation("Idle")
	host.velocity.x = 0
	host.velocity.y = 0
	return

func exit(host):
	return "Walk"
