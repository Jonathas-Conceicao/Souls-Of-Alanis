extends Area2D

func _input(event):
	
	if event.is_action_pressed("ui_up"):
		$fchest/Open_chest_area.hide()
