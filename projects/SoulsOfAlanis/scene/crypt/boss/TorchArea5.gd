extends Area2D

func _on_TorchArea_body_entered(body):
	if body.get_name() == "Player":
		$AnimatedSprite19.play("BurnBabyBurn")
		$AnimatedSprite20.play("BurnBabyBurn")
