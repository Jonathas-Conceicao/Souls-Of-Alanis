extends Node

var NumExit = 2
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getNumExit():
	return NumExit

func getSceneType():
	return RoomType.connection

func getSceneHalf():
	return Half.first

func getSize():
	return Vector2(1.09, 2.8)