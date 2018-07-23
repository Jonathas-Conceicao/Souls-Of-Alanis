extends "Cinematic.gd"

var introText = "And so she awakens of that strange dream she had."

var texts = [ "What a crazy ride that was."]

func _input(event):
	if event.is_action_pressed("player_debug"):
		emit_signal("finished_cinematic", self)
	return

func _ready():
	self.init(self.s, self.introText, self.texts)
	._ready()
	$CreditsBlock.enabled(false)
	self.start("Intro")
	return

func enabled(b):
	if $Background != null:
		$Background.visible = b
	if $Background/Alanis != null:
		$Background/Alanis.visible = b
	if $Background/FirePlace != null:
		$Background/FirePlace.visible = b
	if $TextBox != null:
		$TextBox.enabled(b)
	return

func _on_CreditsBlock_finished_dialog():
	emit_singnal("finished_cinematic", self)
	return
