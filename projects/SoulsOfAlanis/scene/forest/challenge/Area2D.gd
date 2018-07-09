extends Area2D

func _input(event):
	
	if event.is_action_pressed("player_jump"):
		$fchest/Open_chest_area.hide()
