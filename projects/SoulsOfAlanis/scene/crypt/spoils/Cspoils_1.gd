extends Node2D

enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func _ready():
	#$GhostBill/Area2D/AnimatedSprite.play()
	return

func getNumExit():
	return 1

func getSceneType():
	return RoomType.ordinary

func getSceneHalf():
	return Half.first

func getSize():
	return Vector2(1, 1)