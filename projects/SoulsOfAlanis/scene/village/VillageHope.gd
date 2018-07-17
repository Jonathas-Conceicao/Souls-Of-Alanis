extends Node2D

func _ready():
	$LocalName.show()
	return

func getSize():
	return Vector2(2, 3.3)
	
func _input(event):
	if event.is_pressed():
		$LocalName.hide()