extends Area2D

var STATE_CHEST = "CLOSED"

func _input(event):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		
		if body.name == "Player" && STATE_CHEST == "CLOSED":
			$Label.show()
			if event.is_action_pressed("ui_up"):
				$Open_se.play()
				$AnimatedSprite.play("opened")
				$Label.hide()
				STATE_CHEST = "OPENED"	
		else:
			$Label.hide()
