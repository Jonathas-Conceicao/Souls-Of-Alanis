extends Node2D

func _ready():
	$CameraLimit.set_limits(3, 3)
	$Player/Camera.update_limits()
	pass
