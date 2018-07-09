extends Node

var NumExit = 2
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func _ready():
	
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_LEFT, 0)
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_RIGHT, 1766)
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_BOTTOM, 647)
	get_tree().get_current_scene().get_node("Player").get_node("Camera2D").set_limit(MARGIN_TOP, 0)
	
func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.ordinary
	
func getSceneHalf():
	return 
