extends Area2D

func _ready():
	pass

func _on_InteractAreaDoor_body_entered(body):
	if body.get_name() == "Player":
		$InteractionSign.show()


func _on_InteractAreaDoor_body_exited(body):
	if body.get_name() == "Player":
		$InteractionSign.hide()
