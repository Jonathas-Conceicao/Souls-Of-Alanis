extends Node2D

func _input(event):
	if event.is_pressed():
		$LocalName.hide()
		set_process_input(false)