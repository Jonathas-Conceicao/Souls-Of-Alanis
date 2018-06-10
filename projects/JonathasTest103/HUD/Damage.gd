extends CanvasItem

func init(host, position, scale, value):
	self.set_as_toplevel(true)
	self.set_position(host.get_position() + position)
	self.setValue(value)
	self.set_scale(Vector2(1.5, 1.5))
	return

func setValue(value = 0):
	$Label.text = str(value)
	$Label.visible = false
	return

func _ready():
	$Animation.play("Base Hit")
	return

func _on_Animation_animation_finished(anim_name):
	self.queue_free()
	return
