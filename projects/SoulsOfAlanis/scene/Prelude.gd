extends Node

var path_vector = ["res://scene/HallwayRoom1.tscn", 
          "res://scene/Corridor1.tscn", 
          "res://scene/Corridor2.tscn",
          "res://scene/HallwayRoom2.tscn",
          "res://scene/LargeRoom1.tscn",
          "res://scene/LootRoom1.tscn",
          "res:://scene/LargeRoom1.tscn"]

func _ready():
  randomize()
  $Toucan/AnimatedSprite.play()
  $Toucan2/AnimatedSprite.play()
  $Toucan3/AnimatedSprite.play()
  $Toucan4/AnimatedSprite.play()
  $Toucan5/AnimatedSprite.play()
  $Toucan6/AnimatedSprite.play()

func randomize_path():
  
  var temp_path = []
  var temp
  
  for i in path_vector.size():
    temp_path.append(randi() % path_vector.size())
    
  for i in path_vector.size():
    temp = temp_path[i]
    temp_path[i] = path_vector[temp]		

  return temp_path

func getSize():
  return Vector2(2,4)