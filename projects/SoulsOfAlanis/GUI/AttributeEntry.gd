extends TextureRect

enum Directions {Up, Down}

var selected = false

export (bool) var focused = false

export (int) var Value = 1
export (String) var Name = "Vitality"

signal finished_interaction

func _input(event):
	if event.is_action_pressed("ui_left") || event.is_action_pressed("ui_up"):
		emit_signal("finished_interaction", Up)
	if event.is_action_pressed("ui_right") || event.is_action_pressed("ui_down"):
		emit_signal("finished_interaction", Down)
	elif event.is_action_pressed("ui_accept"):
		emit_signal("finished_interaction", 2)
	return

func test_ready():
	self.selected(true)
	return

func _ready():
	$Selection.set_global_position($PlusContainer/Plus.get_global_position())
	self.focused(self.focused)
	self.update()
	set_process_input(false)
	# self.test_ready()
	return

func update():
	$TextContainer/Name.set_text(self.Name)
	$NumberContainer/Value.set_text(str(self.Value))
	return

func set_value(v):
	self.Value = v
	self.update()
	return

func focused(b):
	self.focused = b
	$PlusContainer/Plus.visible = self.focused
	return

func selected(b):
	$Selection.visible = b
	self.selected = b
	set_process_input(b)
	return
