extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

#func _ready():
#	$CameraLimit.set_limits(1, 1.29)
#	$Player/Camera.update_limits()

func getSceneType():
	return RoomType.connection

func getSceneHalf():
	return Half.first

func getMaxRep():
	return 3

func getNumExit():
	return 1

func listNPC():
	pass

func listChest():
	pass

func getSize():
	return Vector2(1, 1.29)