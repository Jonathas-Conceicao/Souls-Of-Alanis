extends Node2D

func set_disabled():
	
	$InteractAreaBill/AnimatedSprite.hide()
	$InteractAreaBill/CollisionShape2D.set_disabled(true)
	
func set_enabled():
	
	$InteractAreaBill/AnimatedSprite.show()
	$InteractAreaBill/CollisionShape2D.set_disabled(false)