extends Label

func setValue(value = 0):
	self.text = str(value)
	self.visible = false
	return

func _ready():
	$Animation.play("Base Hit")
	return

func _on_Animation_animation_finished(anim_name):
	self.queue_free()
	return
