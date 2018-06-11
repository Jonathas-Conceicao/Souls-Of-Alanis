extends Area2D

var motion = Vector2()

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		
		if body.name == "Player":
			$Toucan7/AnimatedSprite.play("fly")