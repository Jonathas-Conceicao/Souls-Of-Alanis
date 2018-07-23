extends "res://script/Classes/Scene.gd"

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }
	
func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.quest
	
func getSceneHalf():
	return Half.first
	
func getMaxRep():
	return 0
	
func listChest():
	pass
	
func listNPC():
	var array = .listNPC()
	array.append($Andre)
	return array

func getSize():
	return Vector2(1, 1.37)