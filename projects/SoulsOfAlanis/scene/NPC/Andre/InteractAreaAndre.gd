extends Area2D

signal finished_dialog

func _ready():
	$TextBox.set_dialog("Andre", "Hello there, I'm Andre. The blacksmith of this realm!")
	$TextBox.add_dialog("I used to be the best. I Forged countless armors and weapons for knights throughout this realm. But, as you can see i don't have my anvil anymore.")
	$TextBox.add_dialog("Actually for my knowledge i guess the anvil is inside this dungeon, i suspect it was stolen")
	$TextBox.add_dialog("So, unless you want to walk around with junk weapons or amor i would suggest you to find that for me")
	$SelectionBox.set_dialog("Andre", "Would like to help me?")
	$SelectionBox.add_item("Yes")
	$SelectionBox.add_item("Nah!")
	return

func _on_player_interaction(host):
	$AnimatedSprite.set_flip_h(true)
	$AnimatedSprite.play()
	$TextBox.enabeled(true)
	return "finished_dialog"

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	return

func _on_TextBox_finished_dialog(obj):
	$TextBox.enabeled(false)
	emit_signal("finished_dialog", self)
		
func _on_InteractArea_body_entered(body):
	if body.find_in_Backpack(0) == -1:
		$HasQuest.show()
	else:
		$NoHasQuest.show()

func _on_InteractArea_body_exited(body):
	if body.get_name() == "Player":	
		$HasQuest.hide()
		$NoHasQuest.hide()
