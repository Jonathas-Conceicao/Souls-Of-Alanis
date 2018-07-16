extends Area2D


func _on_InteractionAreaSign_body_entered(body):
	if body.get_name() == "Player":
		$InteractionSign.show()
		
		if Input.is_action_pressed("ui_up"):
			print("teste")
		
func _on_InteractionAreaSign_body_exited(body):
	if body.get_name() == "Player":
		$InteractionSign.hide()
