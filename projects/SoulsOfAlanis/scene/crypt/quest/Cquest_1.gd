extends Node2D

enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func _ready():
	return

func getNumExit():
	return 0

func getSceneType():
	return RoomType.ordinary

func getSceneHalf():
	return Half.first

func getSize():
	return Vector2(1, 1)