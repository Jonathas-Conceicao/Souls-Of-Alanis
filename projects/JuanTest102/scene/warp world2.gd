extends Area2D

func _ready():
	randomize()

func _physics_process(delta):
	
	var rand_map
	
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			rand_map = randi() % 4 + 2
					
			get_tree().change_scene("res://scene/World" +str(rand_map)+".tscn")		