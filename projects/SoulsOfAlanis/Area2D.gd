extends Area2D

signal finished_dialog

func _ready():
#	$TextBox.set_dialog("Ghost Bill", "I'm Bill, you can call me Ghost.")
#	$TextBox.add_dialog("When you gaze long enough into the abyss, the abyss starts to gazes into you.")
	return

func _on_player_interaction(host):
	$AnimatedSprite.play()
	$TextBox.enabeled(true)
	return "finished_dialog"

func _on_AnimatedSprite_animation_finished():
#	$AnimatedSprite.stop()
	return

func _on_TextBox_finished_dialog(obj):
	$TextBox.enabeled(false)
	emit_signal("finished_dialog", self)
