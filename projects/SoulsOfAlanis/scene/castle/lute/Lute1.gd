extends Node2D

const N_EXIT = 5

func _ready():
  $CameraLimit.set_limits(2, 3)
  $Player/Camera.update_limits()
  pass
