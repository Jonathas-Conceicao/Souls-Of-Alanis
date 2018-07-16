extends "Cinematic.gd"

var speacker = "Storyteller"
var introText = "This is Alanis"

var texts = ["This is a text from the list"
	,"This one is also text from the list"]

func _ready():
	$TextBox.set_dialog(self.speacker, self.introText)
	for text in self.texts:
		$TextBox.add_dialog(text)
	self.start("Intro")
	return

func start(s):
	play(s)
	$TextBox.enabeled(true)
	return

func _on_TextBox_finished_dialog(box):
	print("Got a 'Dialog Finished")
	emit_signal("finished_cinematic", self)
	return
