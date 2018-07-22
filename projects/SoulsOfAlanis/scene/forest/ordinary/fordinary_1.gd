extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getNumExit():
	return NumExit
	
func getMaxRep():
	return 2

func getSceneType():
	return RoomType.ordinary

func getSceneHalf():
	return Half.first

func getSize():
	return Vector2(2, 2.07)
