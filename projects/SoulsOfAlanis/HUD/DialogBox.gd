extends CanvasLayer

enum POSITION {Up, Down}
export(POSITION) var Position = POSITION.Down
export var HIGHT = 180
export var NUMBER_CHAR = 305
export var MARGIN = 10

signal finished_dialog

var texts = []

func _input(event):
	if event.is_action_pressed("ui_accept"):
		self.next_text()
	return

func _ready():
	$NPPainel/RedButton.visible = false
	$NPPainel/GreenButton.visible = true
	self.update_position()
	return

func update_position():
	$NPPainel.set_margin(0, self.MARGIN)
	$NPPainel.set_margin(2, - self.MARGIN)
	if Position == POSITION.Up:
		$NPPainel.set_anchor(1, 0, false, true)
		$NPPainel.set_anchor(3, 0, false, true)
		$NPPainel.set_margin(1, self.MARGIN)
		$NPPainel.set_margin(3, (self.HIGHT + self.MARGIN))
	else:
		$NPPainel.set_anchor(1, 1, false, true)
		$NPPainel.set_anchor(3, 1, false, true)
		$NPPainel.set_margin(1, - (self.HIGHT + self.MARGIN))
		$NPPainel.set_margin(3, - self.MARGIN)
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

func set_speaker(name):
	$NPPainel/Title.set_text(name + ":")
	return
