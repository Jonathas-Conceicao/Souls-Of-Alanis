extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getMaxRep():
	return 2

func getNumExit():
	return NumExit

func getSceneType():
	return RoomType.ordinary

func getSceneHalf():
	return Half.first
	
func listNPC():
	pass
	
func listChest():
	pass

func getSize():
	return Vector2(1.8, 1.3)