extends Control

export (String) var text = ""

func _ready():
	$Label.set_text(self.text)
	self.set_selected(false)
	return

func set_selected(b):
	$Selecton.visible = b
	return

func set_text(text):
	self.text = text
	$Label.set_text(text)
	return
