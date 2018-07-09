extends Node

func _ready():
	
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_TOP, 285)
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_BOTTOM, 0)
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_RIGHT, 1584)
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_LEFT, 0)
