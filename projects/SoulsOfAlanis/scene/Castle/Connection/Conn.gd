extends Node2D

func _ready():
	$CameraLimit.set_limits(1, 2)
	$Player/Camera.update_limits()
	pass
