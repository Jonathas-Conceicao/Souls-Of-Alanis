extends "res://HUD/TextBox.gd"

var texts = []

func _input(event):
	if event.is_action_pressed("ui_accept"):
		self.next_text()
	return

func set_dialog(name, text):
	self.set_speaker(name)
	self.gen_list(text)
	self.next_text()
	return

func gen_list(text):
	var tempText
	for i in range(0, text.length()):
		if i % NUMBER_CHAR == 0:
			texts.push_back(text.substr(i, NUMBER_CHAR))
	return

func next_text():
	self.update_position()
	var next
	next = texts.pop_front()
	if next:
		set_text(next)
	else:
		emit_signal("finished_dialog")
	return

func set_text(text):
	$NPPainel/Main.clear()
	$NPPainel/Main.add_text(text)
	return
