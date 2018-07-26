extends Area2D

func _on_ThiefAnimationLimit_body_entered(body):
	$OldThief/InteractAreaThief/AnimatedSprite.play()
	pass
