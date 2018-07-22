extends Area2D

signal finished_dialog

func _ready():
	$TextBox.set_dialog("Old Thief", "A thief never rest!")
	return

func _on_player_interaction(host):
	$AnimatedSprite.set_flip_h(true)
	$AnimatedSprite.play()
	$TextBox.enabled(true)
	return "finished_dialog"

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	return

func _on_TextBox_finished_dialog(obj):
	$TextBox.enabled(false)
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