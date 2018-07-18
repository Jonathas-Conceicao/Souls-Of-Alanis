extends Node2D

func _input(event):
	if event.is_action_pressed("disabled_NPC"):
		$GhostBill.set_enabled(false)
		$Andre.set_enabled(false)
		$OldThief.set_enabled(false)
		
	if event.is_action_pressed("enabled_NPC"):
		$GhostBill.set_enabled(true)
		$Andre.set_enabled(true)
		$OldThief.set_enabled(true)
		
	if event.is_pressed():
		$LocalName.hide()