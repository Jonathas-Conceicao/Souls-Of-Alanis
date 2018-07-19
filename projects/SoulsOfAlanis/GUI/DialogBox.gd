extends "res://GUI/TextBox.gd"

enum State {Idle, Working}

export(bool) var enabled = true
export(State) var state = 0

var texts = []
var lastTextSize = 0
onready var Main = $NPPainel/Main
onready var GButton = $NPPainel/GreenButton
onready var RButton = $NPPainel/RedButton

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if state == Idle:
			self.next_text()
		else:
			self.show_all()
	return

func _ready():
	self.update()
	return

func update():
	$NPPainel.visible = self.enabled
	set_process_input(self.enabled)
	return

func enabeled(b):
	Main.set_visible_characters(0)
	self.enabled = b
	self.update()
	self.update_state()
	set_process_input(b)
	return

func set_dialog(name, text):
	self.set_speaker(name)
	self.gen_list(text)
	self.next_text()
	return

func add_dialog(text):
	self.gen_list(text)
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
		Main.set_visible_characters(0)
		self.update_state()
	else:
		emit_signal("finished_dialog", self)
	return

func set_text(text):
	Main.clear()
	Main.add_text(text)
	return

func show_more():
	var visible = Main.get_visible_characters()
	Main.set_visible_characters(visible + 1)
	return

func show_all():
	Main.set_visible_characters(-1)
	return

func update_state():
	var visible = Main.get_visible_characters()
	var length = Main.get_text().length()
	if not self.enabled || visible == -1 || visible == length:
		self.state = Idle
		RButton.visible = false
		GButton.visible = true
		$Timer.stop()
	else:
		self.state = Working
		self.show_more()
		GButton.visible = false
		RButton.visible = true
		$Timer.start()
	return

func _on_Timer_timeout():
	self.update_state()
