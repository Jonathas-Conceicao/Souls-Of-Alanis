extends Node2D

func _input(event):
	if event.is_action_pressed("disabled_NPC"):
		$GhostBill.set_disabled()
		$Andre.set_disabled()
		$OldThief.set_disabled()
		
	if event.is_action_pressed("enabled_NPC"):
		$GhostBill.set_enabled()
		$Andre.set_enabled()
		$OldThief.set_enabled()