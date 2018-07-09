extends Area2D

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		
		if body.name == "Player":
			$Label.show()
			if Input.is_action_pressed("ui_up"):
				print("troquei de sala")
		else:
			
			$Label.hide()
