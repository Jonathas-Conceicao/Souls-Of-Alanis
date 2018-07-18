extends Node2D

func set_disabled():
	
	$InteractAreaAndre/AnimatedSprite.hide()
	$InteractAreaAndre/CollisionShape2D.set_disabled(true)
	
func set_enabled():
	
	$InteractAreaAndre/AnimatedSprite.show()
	$InteractAreaAndre/CollisionShape2D.set_disabled(false)
