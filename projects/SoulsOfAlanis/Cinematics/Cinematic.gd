extends AnimationPlayer

signal finished_cinematic

var s = "Storyteller"
var i = " " # @Jonathas Make this better

var t = []

func init(s, i, t):
	self.s = s
	self.i = i
	self.t = t
	return self

func _ready():
	$TextBox.set_dialog(self.s, self.i)
	$TextBox.add_lines(self.t)
	return

func start(s):
	play(s)
	$TextBox.enabled(true)
	return

func enabled(b):
	$TextBox.enabled(b)
	return

func _on_TextBox_finished_dialog(box):
	if !has_animation("Outro"):
		emit_signal("finished_cinematic", self)
	else:
		self.play("Outro")
	return

func _on_Self_animation_finished(anim_name):
	if anim_name == "Outro":
		emit_signal("finished_cinematic", self)
	return
