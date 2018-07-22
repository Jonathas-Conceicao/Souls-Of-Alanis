extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

func _ready():
	$Torchs.burn_baby_burn()
	$AreaTheme.play()
	
#func listNPC():
#	return null
	
#func listChests():
#	return null

func getSceneType():
	return RoomType.final

func getNumExit():
	return 1
	
func getSize():
	return Vector2(2.5, 2.8)

func _on_CloseDoorArea_body_entered(body):
	if body.get_name() == "Player":
		$AreaTheme.stop()
