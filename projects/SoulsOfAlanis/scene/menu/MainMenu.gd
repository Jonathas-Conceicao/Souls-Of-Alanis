extends Control

export (PackedScene) var StartScene = null
export (PackedScene) var CreditScene = null

func _ready():
	#$Closing.enabled(false)
	#$Closing.connect("finished_dialog", self, "_go_Back")
	return

func _go_Back(back_from):
	#$Closing.enabled(false)
	return

func _on_Credits_pressed():
	#$Closing.enabled(true)
	#$Closing.start("Outro")
	return

func _on_Exit_pressed():
	get_tree().quit()
	return

func _on_NewGame_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()
	return

func _on_FadeIn_fade_finished():
	get_tree().change_scene_to(StartScene)
	return
