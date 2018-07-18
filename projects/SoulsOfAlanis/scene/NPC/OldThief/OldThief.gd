extends Node2D

func set_disabled():
	
	$InteractAreaThief/AnimatedSprite.hide()
	$InteractAreaThief/CollisionShape2D.set_disabled(true)
	
func set_enabled():
	
	$InteractAreaThief/AnimatedSprite.show()
	$InteractAreaThief/CollisionShape2D.set_disabled(false)