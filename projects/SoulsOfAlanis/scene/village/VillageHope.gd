extends Node2D

func _ready():
	$LocalName.show()
	#get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_LEFT, 0)
	#get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_RIGHT, 2880)
	#get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_BOTTOM, 1152)
	#get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_TOP, 0)

func getSize():
	return Vector2(2, 4)
	
func _input(event):
	if event.is_pressed():
		$LocalName.hide()