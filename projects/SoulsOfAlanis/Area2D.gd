extends "res://script/Classes/Unique.gd"

signal finished_dialog

func _ready():
#	$TextBox.set_dialog("Ghost Bill", "I'm Bill, you can call me Ghost.")
#	$TextBox.add_dialog("When you gaze long enough into the abyss, the abyss starts to gazes into you.")
	return

func _on_player_interaction(host):
	$AnimatedSprite.play()
	$TextBox.enabeled(true)
	host.add_to_Chests(self.get_uniqueID())
	return "finished_dialog"

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	return

func _on_TextBox_finished_dialog(obj):
	$TextBox.enabeled(false)
	emit_signal("finished_dialog", self)

##ADDED
func enabled(t = true):
	if !t:
		#TODO show a open chest
		#remove after proper implementation
		.enabled(t)
	return

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	return global_ids.unique_ids.npc_ghost_bill