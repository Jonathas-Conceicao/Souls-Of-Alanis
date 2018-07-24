extends "Cinematic.gd"

var introText = "And so she awakens of that strange dream she had."

var texts = [ "What a crazy ride that was."]
var readyToLeave = false

func _input(event):
	if event.is_action_pressed("player_debug") || self.readyToLeave:
		emit_signal("finished_cinematic", self)
	return

func _ready():
	self.init(self.s, self.introText, self.texts)
	._ready()
	$CreditsBlock.enabled(false)
	return

func enabled(b):
	$Background.visible = b
	$Background/Alanis.visible = b
	$Background/FirePlace.visible = b
	$TextBox.enabled(b)
	$CreditsBlock.visible = b
	set_process_input(b)
	return

func readyToLeave():
	self.readyToLeave = true
	return

func _on_Self_animation_finished(anim_name):
	if anim_name == "Outro": self.readyToLeave = true
	._on_Self_animation_finished(anim_name)
	return

func _on_CreditsBlock_finished_dialog():
	emit_singnal("finished_cinematic", self)
	return
