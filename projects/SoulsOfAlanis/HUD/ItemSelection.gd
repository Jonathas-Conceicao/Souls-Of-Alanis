extends Control

func _ready():
	set_text("AAAAAAAAAAAAAAAA")
	selected(false)
	return

func set_text(t):
	$Text.set_text(t)
	return

func selected(b):
	$Icon.visible = b
