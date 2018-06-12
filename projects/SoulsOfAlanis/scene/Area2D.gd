extends Area2D

onready var newScene = "res://scene/BigFRoom.tscn"

func _physics_process(delta):
  var bodies = get_overlapping_bodies()
  
  for b in bodies:
    if b.name == "Player":
      get_tree().change_scene(newScene)