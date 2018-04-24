# Main class, first things first
extends Node

# each scene must have a left and right new scene to load,
# case it's NULL, then that should not be loaded!

func _ready():
  randomize()
  pass

func _on_newgame_pressed():
  get_tree().change_scene("res://scene/World1.tscn")
