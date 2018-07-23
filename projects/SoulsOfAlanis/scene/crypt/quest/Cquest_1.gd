extends Node2D

enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getNumExit():
	return 1
	
func getMaxRep():
	return 0

func getSceneType():
	return RoomType.quest

func getSceneHalf():
	return Half.first
	
func listChest():
	pass

func listNPC():
	var array = .listNPC()
	array.append($GhostBill)
	return array

func getSize():
	return Vector2(1, 1.12)