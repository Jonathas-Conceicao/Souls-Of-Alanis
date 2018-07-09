extends Area2D

func _ready():
	$TextBox.set_dialog("Ghost Bill", "I'm Bill, you can call me Ghost.")
	$TextBox.add_dialog("When you gaze long enough into the abyss, the abyss starts to gazes into you.")
	return

func _input(event):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		
		if body.name == "Player":
			#$LabelName.show()
			
			if event.is_action_pressed("ui_up"):
				$AnimatedSprite.play()
				# $TextBox/DialogPainel.show()
				$TextBox.enabeled(true)
				#$LabelName.hide()
				
		else:
			$LabelName.hide()
			if event.is_action_pressed("ui_accept"):
				$TextBox/DialogPainel.hide()
				$TextBox.set_text("When you gaze long into an abyss the abyss also gazes into you.")
				$TextBox/DialogPainel/ItemList.show()
		

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()

func _on_TextBox_finished_dialog(obj):
	$TextBox.enabeled(false)
