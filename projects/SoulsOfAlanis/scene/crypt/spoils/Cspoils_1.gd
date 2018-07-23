extends Node2D

enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func _ready():
	return

func getNumExit():
	return 1
	
func getMaxRep():
	return 1

func getSceneType():
	return RoomType.loot

func getSceneHalf():
	return Half.first
	
func listNPC():
	pass
	
func listChest():
	var array = .listChest()
	array.append($fchest)
	return array

func getSize():
	return Vector2(1, 1)