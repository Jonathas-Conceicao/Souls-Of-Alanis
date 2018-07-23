extends "State.gd"

func enter(host):
	host.set_animation("Idle")
	host.velocity.x = 0
	host.velocity.y = 40
	host.update_flip()
	return

func handle_input(host, command):
	match command:
		0: return "Seek"
		1: return "Destroy"
		_: pass
	return
