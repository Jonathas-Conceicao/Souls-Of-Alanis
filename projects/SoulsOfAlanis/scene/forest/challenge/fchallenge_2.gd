extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.challenge
	
func getSceneHalf():
	return Half.first

func getSize():
	return Vector2(1, 1.37)
	
func _ready():
	$ChallengeDisplay.set_text("Don't take damage!")
	$ChallengeDisplay.update_text()
	$ChallengeDisplay.set_state(0)
	$ChallengeDisplay.update_state()