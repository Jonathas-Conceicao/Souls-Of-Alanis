extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

func getSceneType():
	return ordinary

func getSceneHalf():
	return first

func getMaxRep():
	return 10

func getNumExit():
	return 1

func getSize():
	return Vector2(1, 1)

func listNPC():
	return []

func listChests():
	return []