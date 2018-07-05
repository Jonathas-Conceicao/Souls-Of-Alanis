extends Control

func set_text(t):
	$Text.set_text(t)
	return

func selected(b):
	$Icon.visible = b
