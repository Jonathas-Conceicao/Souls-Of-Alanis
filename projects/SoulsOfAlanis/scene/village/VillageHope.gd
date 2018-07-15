extends Node2D

func _ready():
	$LocalName.show()

func getSize():
	return Vector2(2, 4)
	
func _input(event):
	if event.is_pressed():
		$LocalName.hide()