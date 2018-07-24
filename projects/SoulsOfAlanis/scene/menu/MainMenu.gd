extends Control

export (PackedScene) var StartScene = preload("res://scene/control/root.tscn")
export (PackedScene) var CreditScene = preload("res://Cinematics/CreditsBlock.tscn")

func _ready():
	$Closing.enabled(false)
	$Closing.connect("finished_cinematic", self, "_go_Back")
	return

func _go_Back(back_from):
	$Closing.enabled(false)
	return

func _on_Credits_pressed():
	if not $Closing.is_playing():
		$Closing.enabled(true)
		$Closing.start("Outro")
		$Closing.seek(0.5)
	release_focus()
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
