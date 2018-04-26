extends Area2D

var talked = false

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_accept") && talked == true:
			$Label2.show()
			$HideTimer.start()
		
		if body.name == "Player" && Input.is_action_pressed("ui_accept") && talked == false:
			talked = true
			$Label.show()
			$LabelQuest.show()
			$HideTimer.start()

func _on_Timer_timeout():
	$Label.hide()
	$Label2.hide()
