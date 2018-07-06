extends 'State.gd'

var windowsize = OS.get_window_size()
var DIRECTION = Vector2(0, 0)

func enter(host):
	host.set_animation("Fly")
	return

func handle_inputIA(host, event):
	match event:
		host.INPUTS.RIGHT:
			DIRECTION.x = 1
		host.INPUTS.LEFT:
			DIRECTION.x = -1
		host.INPUTS.UP:
			DIRECTION.y = -1
		host.INPUTS.DOWN:
			DIRECTION.y = 1
	return

func update(host, delta):
	host.velocity = DIRECTION * host.BASE_SPEED
	return
