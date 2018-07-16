extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

export (int) var num_exit = 2

func getSceneType():
	return ordinary

func getSceneHalf():
	return first

func getMaxRep():
	return 3

func getNumExit():
	return self.num_exit

func getSize():
	return Vector2(2, 2)