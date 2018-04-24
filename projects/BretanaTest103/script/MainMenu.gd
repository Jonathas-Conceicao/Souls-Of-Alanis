# MainMenu class, once the menu scene is load, it's this guy turn
extends Node

func _on_newgame_pressed():
  get_tree().change_scene("res://scene/World1.tscn")
