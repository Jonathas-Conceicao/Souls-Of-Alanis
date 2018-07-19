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
	return Vector2(4.7, 2.7)
	
func _ready():
	
	$ChallengeDisplay.set_text("don't jump")
	
func _input(event):
	if event.is_action_pressed("ui_up"):
		#$ChallengeDisplay.set_state()