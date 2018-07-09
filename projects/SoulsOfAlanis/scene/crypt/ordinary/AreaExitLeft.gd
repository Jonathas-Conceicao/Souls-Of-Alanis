extends Area2D

func _input(event):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		
		if body.name == "Player":
			$Sprite2.show()
			
		else:
			$Sprite2.hide()