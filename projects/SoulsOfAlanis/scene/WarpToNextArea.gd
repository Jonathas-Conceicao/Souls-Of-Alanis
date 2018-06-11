extends Area2D

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
	var new_path
	
	for body in bodies:
		
		if body.name == "Player":
			new_path = temp_path
			get_tree().change_scene(new_path)