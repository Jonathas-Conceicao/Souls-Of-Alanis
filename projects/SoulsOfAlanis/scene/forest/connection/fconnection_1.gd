extends Node

var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getNumExit():
	return NumExit

func getSceneType():
	return RoomType.connection

func getSceneHalf():
	return Half.first
	
func getMaxRep():
	return 2
	
func listNPC():
	pass
	
func listChest():
	pass

func getSize():
	return Vector2(1.09, 2.8)