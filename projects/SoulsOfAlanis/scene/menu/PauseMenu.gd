extends CanvasLayer

signal finished_interation

func _ready():
	pass

func _on_ExitButton_pressed():
	get_tree().quit()
	return

func _on_ContinueButton_pressed():
	emit_signal("finished_interation", self)
	return

func _on_NewGameButton_pressed():
	return