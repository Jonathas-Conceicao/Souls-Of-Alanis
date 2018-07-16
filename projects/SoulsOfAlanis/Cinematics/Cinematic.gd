extends AnimationPlayer

signal finished_cinematic

var s = "Storyteller"
var i = ""

var t = []

func init(s, i, t):
	self.s = s
	self.i = i
	self.t = t
	return self

func _ready():
	$TextBox.set_dialog(self.s, self.i)
	for text in self.t:
		$TextBox.add_dialog(text)
	self.start("Intro")
	return

func start(s):
	play(s)
	$TextBox.enabeled(true)
	return

func _on_TextBox_finished_dialog(box):
	emit_signal("finished_cinematic", self)
	return
