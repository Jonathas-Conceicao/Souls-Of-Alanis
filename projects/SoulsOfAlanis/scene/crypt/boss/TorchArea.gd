extends Area2D

func _on_TorchArea_body_entered(body):
	if body.get_name() == "Player":
		$AnimatedSprite11.play("BurnBabyBurn")
		$AnimatedSprite12.play("BurnBabyBurn")