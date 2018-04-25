extends KinematicBody2D

enum STATE {
	IDLE,
	HITED
}

var state = IDLE

func _ready():
	state = IDLE
	pass

func _on_meele_hit(hitter):
	state = HITED
	$Label.show()