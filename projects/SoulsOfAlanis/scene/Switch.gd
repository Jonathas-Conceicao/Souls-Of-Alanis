extends KinematicBody2D

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_attak"):
			$SwitchPlatformer.show()
	