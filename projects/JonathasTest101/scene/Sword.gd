extends Area2D

func _ready():
	$Animation.play("Idle")
	Animation_idle()
	pass

func Animation_idle():
	if $Sprite.animation != "Idle":
		$Animation.play("Idle")
	return