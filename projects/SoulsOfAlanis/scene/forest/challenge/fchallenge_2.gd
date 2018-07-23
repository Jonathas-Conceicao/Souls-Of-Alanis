extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

#func _ready():
#	$CameraLimit.set_limits(1, 1.35)
#	$Player/Camera.update_limits()

func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.challenge
	
func getSceneHalf():
	return Half.first
	
func getMaxRep():
	return 1
	
func listNPC():
	pass
	
func listChest():
	var array = .listChest()
	array.append($fchest)
	return array

func getSize():
	return Vector2(1, 1.35)
	
func _ready():
	$ChallengeDisplay.set_text("Don't take damage!")
	$ChallengeDisplay.update_text()
	$ChallengeDisplay.set_state(0)
	$ChallengeDisplay.update_state()