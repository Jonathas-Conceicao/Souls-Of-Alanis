extends Node

signal ReloadGame

func die(player):
	if player.data.getHP() <= 0:
		emit_signal("ReloadGame", self, false)
		pass
	return