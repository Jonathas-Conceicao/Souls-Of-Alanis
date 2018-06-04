extends Area2D

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_attak"):
			print ("i'm collide with player")
			$PlatformerControl.show()
			$Sprite2.show()
			
		if Input.is_action_just_pressed("ui_attak") || Input.is_action_just_pressed("ui_accept"):
			$Sprite2.hide()