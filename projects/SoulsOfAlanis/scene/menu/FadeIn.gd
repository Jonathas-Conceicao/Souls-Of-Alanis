extends ColorRect

signal fade_finished

func fade_in():
	$transition.play("fade_in_0")
	return

func _ready():
	pass

func _on_transition_animation_finished(anim_name):
	emit_signal("fade_finished")
