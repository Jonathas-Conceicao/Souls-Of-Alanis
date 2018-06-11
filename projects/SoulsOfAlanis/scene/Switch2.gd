extends Area2D

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_attack"):
			$off.hide()
			$on.show()
			show_switch_platformers() 
			
func show_switch_platformers():
	
	$Platformer.show()
	$Platformer/CollisionShape2D.set_disabled(false)
	$Platformer2.show() 
	$Platformer2/CollisionShape2D.set_disabled(false)
	$Platformer3.show() 
	$Platformer3/CollisionShape2D.set_disabled(false) 
	$Platformer4.show()
	$Platformer4/CollisionShape2D.set_disabled(false) 
	$Platformer5.show()
	$Platformer5/CollisionShape2D.set_disabled(false) 
	$Platformer6.show()
	$Platformer6/CollisionShape2D.set_disabled(false)