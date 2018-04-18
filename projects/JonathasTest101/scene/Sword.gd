extends Area2D

func _ready():
	$Animation.play("Idle")
	return

func Animation_idle():
	$Animation.play("Idle")
	return
