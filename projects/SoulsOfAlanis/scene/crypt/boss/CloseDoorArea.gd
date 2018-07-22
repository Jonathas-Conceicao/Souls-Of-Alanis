extends Area2D

func _on_CloseDoorArea_body_entered(body):
	if body.get_name() == "Player":
		$DoorControlRight.set_visible(true)
		$DoorControlRight/StaticBody2D/CollisionShape2D.set_disabled(false)
		$DoorControlLeft.set_visible(true)
		$DoorControlLeft/StaticBody2D/CollisionShape2D.set_disabled(false)
