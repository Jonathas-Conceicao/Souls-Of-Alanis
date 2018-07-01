extends Node2D

func _ready():
  $CameraLimit.set_limits(2, 4)
  $Player/Camera.update_limits()
  pass
