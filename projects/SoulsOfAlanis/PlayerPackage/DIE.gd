extends Node

func die(player):
  if player.data.getHP() <= 0:
#		get_tree().paused = tru
    get_tree().change_scene("res://scene/Prelude.tscn")
  return