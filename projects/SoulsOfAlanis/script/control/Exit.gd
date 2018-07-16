extends Area2D

export (int) var ExitIndex = 0
export (bool) var Blocked = false

func _get_exit():
	return self.ExitIndex

func _on_Exit_body_entered(body):
	if !self.Blocked && body.get_name() == "Player":
		$InteractionSign.show()


func _on_Exit_body_exited(body):
	if body.get_name() == "Player":
		$InteractionSign.hide()