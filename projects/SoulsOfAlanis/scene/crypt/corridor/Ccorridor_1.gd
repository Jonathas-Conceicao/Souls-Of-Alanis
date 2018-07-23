extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

func _ready():
	#$CameraLimit.set_limits(3, 1.3)
	#$Player/Camera.update_limits()
	return

func getSceneType():
	return RoomType.connection

func getSceneHalf():
	return Half.first

func getMaxRep():
	return 3

func getNumExit():
	return 2

func listNPC():
	pass

func listChest():
	pass

func getSize():
	return Vector2(3, 1.3)