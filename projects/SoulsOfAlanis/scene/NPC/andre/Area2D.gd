extends Area2D

func _input(event):
	
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		
		if body.name == "Player":
			$LabelName.show()
			
			if event.is_action_pressed("ui_up"):
				$AnimatedSprite.play()
				$TextBox/DialogPainel.show()
				$LabelName.hide()
				
		else:
			$LabelName.hide()
			if event.is_action_pressed("ui_accept"):
				$TextBox/DialogPainel.hide()
				$TextBox.set_text("Would like to buy something?")
				$TextBox/DialogPainel/ItemList.show()
		

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()

func _on_MarkLimitDialog_body_entered(body):
	if body.name == "Player":
		$TextBox/DialogPainel.hide()
		$TextBox/SaleItemList.hide()
