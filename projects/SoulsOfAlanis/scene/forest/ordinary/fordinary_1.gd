extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

#func _ready():
#	$CameraLimit.set_limits(1.3, 2.06)
#	$Player/Camera.update_limits()

func getNumExit():
	return NumExit
	
func getMaxRep():
	return 2

func getSceneType():
	return RoomType.ordinary

func getSceneHalf():
	return Half.first
	
func listNPC():
	return []
	
func listChest():
	return []

func getSize():
	return Vector2(1.3, 2.06)
