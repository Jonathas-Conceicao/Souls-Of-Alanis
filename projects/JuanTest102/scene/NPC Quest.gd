extends Area2D

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_accept"):
			show_menu()
	
func show_menu():
	$NPCName.hide()
	$LabelMenu.show()
	$VBoxContainer.show()

func _on_YesButton_pressed():
	$VBoxContainer.hide()
	$LabelMenu.hide()
	$HideTimer.start()

func _on_HideTimer_timeout():
	$NPCName.show()
