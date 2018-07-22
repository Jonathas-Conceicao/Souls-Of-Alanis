extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

	
func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.loot
	
func getSceneHalf():
	return Half.any

func getSize():
	return Vector2(1, 1.32)