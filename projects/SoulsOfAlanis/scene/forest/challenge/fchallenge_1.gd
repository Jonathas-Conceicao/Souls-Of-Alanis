extends Node

export var NumExit = 2
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

func getNumExit():
	return NumExit
	
func getSceneType():	
	return RoomType.challenge
	
func getSceneHalf():
	return Half.first

func getSize():
	return Vector2(4.5, 2.8)
	
func _ready():
	$ChallengeDisplay.set_text("Don't Jump")
	$ChallengeDisplay/NPPainel/Container/Message.set_text("Don't Jump")