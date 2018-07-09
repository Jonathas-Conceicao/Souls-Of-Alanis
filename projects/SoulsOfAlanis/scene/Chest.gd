extends Area2D

var itemID

func _physics_process(delta):
  
  var bodies = get_overlapping_bodies()
  var item
  
  for body in bodies:

    if body.name == "Player" && Input.is_action_pressed("ui_attack"):
      print("que")
      $Closed.hide()
      $Opened.show()