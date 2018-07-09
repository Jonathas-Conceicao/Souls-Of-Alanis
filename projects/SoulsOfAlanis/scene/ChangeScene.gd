extends Area2D

onready var newScene = "res://scene/HallwayRoom1.tscn"

func _physics_process(delta):
  var bodies = get_overlapping_bodies()
  
  for b in bodies:
    if b.name == "Player":
      get_tree().change_scene(newScene)

func _get_exit():
  return 0