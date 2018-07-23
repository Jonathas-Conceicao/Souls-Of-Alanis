extends 'State.gd'

func enter(host):
	host.set_animation("Death")
	host.CollisionShape2D.set_disabled()
	host.velocity.x = 0
	host.velocity.y = 0
	return

func update(host, delta):
	host.velocity.x = 0
	host.velocity.y = 0
	return

func _on_animation_finished(host, anim_name):
	if anim_name == "Death":
		host.queue_free()
	return
