extends Area2D

signal challenge_completed

func _on_WinArea_body_entered(body):	
	if body.get_name() == "Player":
		emit_signal("challenge_completed")

func set_enabled(value):
	if value:
		$CollisionShape2D.set_disabled(false)
	else:
		$CollisionShape2D.set_disabled(true)