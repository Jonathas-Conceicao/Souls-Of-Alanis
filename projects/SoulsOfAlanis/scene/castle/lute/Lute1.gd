extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

func _ready():
	$CameraLimit.set_limits(getSize().x, getSize().y)
	$Player/Camera.update_limits()

func getSceneType():
	return loot

func getSceneHalf():
	return first

func getMaxRep():
	return 3

func getNumExit():
	return 1

func getSize():
	return Vector2(2, 3)
