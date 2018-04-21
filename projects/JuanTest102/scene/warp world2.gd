extends Area2D

func _physics_process(delta):
	
	var rand_map
	
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			randomize()
			rand_map = randi() % 4 + 2
					
			if rand_map == 2:
				get_tree().change_scene("res://scene/World" +str(rand_map)+".tscn")
								
			if rand_map == 3:
				get_tree().change_scene("res://scene/World"+str(rand_map)+".tscn")
				
			if rand_map == 4:	
				get_tree().change_scene("res://scene/World"+str(rand_map)+".tscn")