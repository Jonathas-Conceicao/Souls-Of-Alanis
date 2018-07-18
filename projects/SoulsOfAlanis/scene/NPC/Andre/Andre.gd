extends Node2D

func set_enabled(value):
	if value:
		$InteractAreaAndre/AnimatedSprite.hide()
		$InteractAreaAndre/CollisionShape2D.set_disabled(true)
	
	else:
		$InteractAreaAndre/AnimatedSprite.show()
		$InteractAreaAndre/CollisionShape2D.set_disabled(false)
