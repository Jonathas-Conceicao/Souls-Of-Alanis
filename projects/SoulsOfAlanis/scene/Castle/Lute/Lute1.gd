extends Node2D

func _ready():
  $CameraLimit.set_limits(2, 3)
  $Player/Camera.update_limits()
  pass