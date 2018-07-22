extends VBoxContainer

signal finished_dialog

const Line = preload("CreditsLine.tscn")

export var NUMBER_CHAR = 305

const T = "Jonathas \"Thatox\" Conceicao"
const A = "Juan \"Asaki\" Rios"
const B = "Lucas Bretana"
const O = "Felipe \"OneEyedAesir\" Gruendemann"

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("finished_dialog", self)
	return

func defaultCreadits():
	var listinha = [
		"Game Design:",
		"%s, %s, %s, %s" % [T, A, B, O],
		"Texts:",
		"%s, %s" % [T, A],
		"Dungeon Design:",
		"%s, %s" % [A, B],
		"Combat Design:",
		"%s, %s" % [T, O],
		"Art:",
		"%s, %s, %s, %s" % [T, B, "OpenGameArt.org", "itch.io"],
		"Special Thanks:",
		"You!"
	]
	self.init(listinha)
	self.enabled(true)
	return

func _ready():
	self.enabled(false)
	self.defaultCreadits()
	return

func init(texts):
	var l
	for txt in texts:
		l = Line.instance()
		l.set_text(txt)
		add_child(l)
	return

func enabled(b):
	set_process_input(b)
	self.visible = b
	return
