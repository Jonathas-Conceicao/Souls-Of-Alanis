extends Area2D

signal finished_dialog

func _ready():
	$DialogBox.set_dialog("Priest", "Greetings young traveler! I am the priest of this little village, and I want to let you know you are very welcome.")
	$DialogBox.add_dialog("If you're an adventurer seeking the Orb of Wishes, know the forest that leads to the Castle can be treacherous.")
	$DialogBox.add_dialog("It is said that only a Knight pure of heart can find his or hers way through the castle.")
	$DialogBox.add_dialog("The only help I can give you at this moment is to pray for the god above to guide your way.")
	$Balloon.enabled(false)
	$Sprite.play("Idle")
	return

func _on_player_interaction(host):
	$Sprite.play("Greet")
	$DialogBox.enabeled(true)
	return "finished_dialog"

func _on_DialogBox_finished_dialog(obj):
	$DialogBox.enabeled(false)
	$Sprite.play("Idle")
	emit_signal("finished_dialog", self)
	return

func _on_Self_body_entered(body):
	if body.get_name() == "Player":
		$Balloon.enabled(true)
	return

func _on_Self_body_exited(body):
	if body.get_name() == "Player":
		$Balloon.enabled(false)
	return
