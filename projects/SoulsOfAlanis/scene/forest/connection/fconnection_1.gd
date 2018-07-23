extends Node

var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

#func _ready():
#	$CameraLimit.set_limits(1.1, 2.85)
#	$Player/Camera.update_limits()

func getNumExit():
	return NumExit

func getSceneType():
	return RoomType.connection

func getSceneHalf():
	return Half.first
	
func getMaxRep():
	return 2
	
func listNPC():
	return []
	
func listChest():
	return []

func getSize():
	return Vector2(1.1, 2.85)