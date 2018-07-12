extends Node

func _ready():
	randomize()
	$Toucan/AnimatedSprite.play()
	$Toucan2/AnimatedSprite.play()
	$Toucan3/AnimatedSprite.play()
	$Toucan4/AnimatedSprite.play()
	$Toucan5/AnimatedSprite.play()
	$Toucan6/AnimatedSprite.play()

# THIS IS NOT USED
func getSize():
	return Vector2(2,4.2)