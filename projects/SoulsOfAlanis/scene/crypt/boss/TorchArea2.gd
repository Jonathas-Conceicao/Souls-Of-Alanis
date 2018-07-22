extends Area2D

func _on_TorchArea_body_entered(body):
	if body.get_name() == "Player":
		$AnimatedSprite13.play("BurnBabyBurn")
		$AnimatedSprite14.play("BurnBabyBurn")
