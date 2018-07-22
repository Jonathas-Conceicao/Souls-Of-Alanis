extends Area2D

func _on_TorchArea_body_entered(body):
	if body.get_name() == "Player":
		$AnimatedSprite15.play("BurnBabyBurn")
		$AnimatedSprite16.play("BurnBabyBurn")
