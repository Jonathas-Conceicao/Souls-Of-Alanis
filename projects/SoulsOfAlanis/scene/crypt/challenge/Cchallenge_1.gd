extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

func getSceneType():
	return RoomType.challenge

func getSceneHalf():
	return Half.first

func getMaxRep():
	return 1

func getNumExit():
	return 1
	
func listNPC():
	pass
	
func listChest():
	var array = .listChest()
	array.append($fchest)
	return array
	
func getSize():
	return Vector2(1, 1.07)
	
func _ready():
	$ChallengeDisplay.set_text("Don't attack!")
	$ChallengeDisplay.update_text()
	$ChallengeDisplay.set_state(0)
	$ChallengeDisplay.update_state()

func _input(event):
	if event.is_action_pressed("player_attack"):
		$ChallengeDisplay.set_state(2)
		$ChallengeDisplay.update_state()
		$fchest/CollisionShape2D.set_disabled(true)
		

func _on_fchest_challenge_completed():
	$ChallengeDisplay.set_text("Completed!")
	$ChallengeDisplay.update_text()
	$ChallengeDisplay.set_state(1)
	$ChallengeDisplay.update_state()
	self.set_process_input(false)