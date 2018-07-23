extends Area2D

func _on_ComingSoonArea_body_entered(body):
	if body.get_name() == "Player":
		$Label.show()

func _on_ComingSoonArea_body_exited(body):
	if body.get_name() == "Player":
		$Label.hide()
