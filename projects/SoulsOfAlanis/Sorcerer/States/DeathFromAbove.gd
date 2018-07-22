extends "State.gd"

func enter(host):
	host.set_animation("DeathFromAbove")
	return

func update(host, delta):
	host.velocity.x = 0
	host.velocity.y += host.GRAVITY
	host.velocity.y = max(40, host.velocity.y)
	return

func _on_animation_finished(host, anim_name):
	return "Seek"
