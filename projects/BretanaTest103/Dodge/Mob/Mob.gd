extends RigidBody2D

export (int) var MIN_SPEED # minimum speed range
export (int) var MAX_SPEED # maximum speed range
var mob_types = ["walk", "swim", "fly"]

func _ready():
  $AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
  pass


func _on_VisibilityNotifier2D_screen_exited():
  queue_free()
  pass # replace with function body
