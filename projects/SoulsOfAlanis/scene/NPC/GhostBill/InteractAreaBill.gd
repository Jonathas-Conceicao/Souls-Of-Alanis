extends "res://script/Classes/Unique.gd"

signal finished_dialog

func _ready():
	$TextBox.set_dialog("Ghost Bill", "I'm Bill, you can call me Ghost.")
	$TextBox.add_dialog("I think you could help me. Some monsters are bothering me, but in this ethereal form i can't hit them.")
	$TextBox.add_dialog("So Can you take them down for me? In exchange i can give a little favor.")
	$TextBox.add_dialog("When you gaze long enough into the abyss, the abyss starts to gazes into you.")
	return

func _on_player_interaction(host):
	$AnimatedSprite.set_flip_h(true)
	$AnimatedSprite.play()
	$TextBox.enabeled(true)
	host.add_to_StartedQuests(self.get_uniqueID())
	return "finished_dialog"

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	return

func _on_TextBox_finished_dialog(obj):
	$TextBox.enabeled(false)
	emit_signal("finished_dialog", self)


func _on_InteractArea_body_entered(body):
	if body.StartedQuests.find(self.get_uniqueID()) != -1:
		$HasQuest.show()
	else:
		$NoHasQuest.show()

func _on_InteractArea_body_exited(body):
	if body.get_name() == "Player":
		$HasQuest.hide()
		$NoHasQuest.hide()

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	return global_ids.unique_ids.npc_ghost_bill