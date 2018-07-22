extends Area2D

func _on_TorchArea_body_entered(body):
	if body.get_name() == "Player":
		$AnimatedSprite17.play("BurnBabyBurn")
		$AnimatedSprite18.play("BurnBabyBurn")
