extends Node

func die(player):
	if player.data.getHP() <= 0:
		get_tree().paused = true
	return