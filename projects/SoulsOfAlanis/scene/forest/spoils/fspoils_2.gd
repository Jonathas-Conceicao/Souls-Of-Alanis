extends Node

var NumExit = 2
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func _ready():
	pass
	
func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.loot
	
func getSceneHalf():
	return 