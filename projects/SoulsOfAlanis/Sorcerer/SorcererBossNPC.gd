extends Area2D

signal finished_dialog

const npcName = "Priest"
const intro = "We meet again, hero!"
const texts = ["I am really glad you made this far.",
			   "The legend says that \"only a Knight pure of heart can find his or hers way through the castle\"",
			   "And as you can see, I'm no Knight, nor am I pure of heart.",
			   "But disguised as an Priest I could fool gullible Knights to open the way for me.",
			   "But no Knight made this far before.",
			   "I shall have the orb!"]

var host

func _ready():
	$Balloon.enabled(false)
	self.set_dialog()
	$Sprite.play("Idle")
	return

func _on_player_interaction(host):
	self.host = host
	$Sprite.play("Greet")
	$DialogBox.enabled(true)
	return "finished_dialog"

func set_dialog():
	$DialogBox.set_dialog(npcName, intro)
	$DialogBox.add_lines(texts)
	return

func enabled(b):
	self.visible = b
	$Collision.disabled = !b
	return

func _on_Self_body_entered(body):
	if body.get_name() == "Player":
		$Balloon.enabled(true)
	return

func _on_Self_body_exited(body):
	if body.get_name() == "Player":
		$Balloon.enabled(false)
	return

func finish_interaction():
	$Balloon.enabled(false)
	$DialogBox.enabled(false)
	emit_signal("finished_dialog", host)
	return

func _on_DialogBox_finished_dialog(box):
	$Sprite.play("Transform")
	return

func _on_Sprite_animation_finished():
	var anim_name = $Sprite.animation
	if anim_name == "Transform":
		self.finish_interaction()
	elif anim_name == "Greet":
		$Sprite.play("Idle")
	return
