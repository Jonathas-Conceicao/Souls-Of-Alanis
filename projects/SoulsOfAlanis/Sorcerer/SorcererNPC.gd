extends Area2D

signal finished_dialog

func _ready():
	$DialogBox.set_dialog("Priest", "Greetings young traveler! I am the priest of this little village, and I want to let you know you are very welcome")
	$DialogBox.add_dialog("If you're an adventurer seeking the Orb of Wishes, know the forest between here and the Castle can be treacherous.")
	$DialogBox.add_dialog("The only help I can give you this moment is to pray for the god above to guide your way.")
	$Balloon.enabled(false)
	return

func _on_player_interaction(host):
	$Sprite.play("Greet")
	$DialogBox.enabeled(true)
	return "finished_dialog"

func _on_DialogBox_finished_dialog(obj):
	$DialogBox.enabeled(false)
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

func _on_BlinkTimer_timeout():
	$Sprite.play("Blink")
	return
