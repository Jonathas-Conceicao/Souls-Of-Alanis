extends "res://script/Classes/Scene.gd"

func getSceneType():
	return ordinary

func getSceneHalf():
	return first

func getMaxRep():
	return 3

func getNumExit():
	return 1

func getSize():
	return Vector2(2, 4)

func listNPC():
	var array = .listNPC()
	array.append($GhostBill)
	return array

func listChest():
	var array = .listChest()
	array.append($fchest)
	return array