extends Node

export var NumExit = 2
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

#func _ready():
#	$CameraLimit.set_limits(2.3, 2.25)
#	$Player/Camera.update_limits()
		
func getNumExit():
	return NumExit
	
func getMaxRep():
	return 3
	
func getSceneType():	
	return RoomType.ordinary
	
func getSceneHalf():
	return Half.first
	
func listNPC():
	pass
	
func listChest():
	pass

func getSize():
	return Vector2(2.3, 2.25)
