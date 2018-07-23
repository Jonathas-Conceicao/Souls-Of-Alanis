extends Node

export var NumExit = 1
enum RoomType { loot, ordinary, connection, quest, challenge, final, any }
enum Half { first, second, any }

#func _ready():
#	$CameraLimit.set_limits(4.6, 3.5)
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
	return Vector2(4.6, 5)
	
func _ready():
	$ChallengeDisplay.set_text("don't jump")
	$ChallengeDisplay.update_text()
	$ChallengeDisplay.set_state(0)
	$ChallengeDisplay.update_state()
	
func _input(event):
	if event.is_action_pressed("player_jump"):
		$ChallengeDisplay.set_state(2)
		$ChallengeDisplay.update_state()
		$fchest/CollisionShape2D.set_disabled(true)
		$WinArea.set_enabled(false)

func _on_WinArea_challenge_completed():
	$ChallengeDisplay.set_state(1)
	$ChallengeDisplay.update_state()
	self.set_process_input(false)
