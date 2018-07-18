extends Node2D

func set_enabled(value):
	if value:
		$InteractAreaThief/AnimatedSprite.hide()
		$InteractAreaThief/CollisionShape2D.set_disabled(true)
	
	else:
		$InteractAreaThief/AnimatedSprite.show()
		$InteractAreaThief/CollisionShape2D.set_disabled(false)