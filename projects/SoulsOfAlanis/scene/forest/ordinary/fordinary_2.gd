extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func _ready():
	$CameraLimit.set_limits(3, 1.3)
	$Player/Camera.update_limits()

func getMaxRep():
	return 2

func getNumExit():
	return NumExit

func getSceneType():
	return RoomType.ordinary

func getSceneHalf():
	return Half.first
	
func listNPC():
	pass
	
func listChest():
	pass

func getSize():
	return Vector2(3, 1.3)