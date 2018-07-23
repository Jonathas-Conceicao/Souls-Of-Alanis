extends "res://script/Classes/Scene.gd"

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

func _ready():
	$Torchs.burn_baby_burn()
	$AreaTheme.play()
	return

func getSceneType():
	return RoomType.final

func getNumExit():
	return 1
	
func getSize():
	return Vector2(2.5, 3.8)

func _on_CloseDoorArea_body_entered(body):
	if body.get_name() == "Player":
		$AreaTheme.stop()
