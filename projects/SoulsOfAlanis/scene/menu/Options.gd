extends VBoxContainer

export (PackedScene) var CREDIT_SCENE = null
export (PackedScene) var StartScene = preload("res://scene/control/root.tscn").instance()

func _ready():
	return

func _on_NewGame_pressed():
	get_tree().change_scene_to(StartScene)
	return

func _on_Credits_pressed():
	get_tree().change_scene_to(CREDIT_SCENE)
	return

func _on_Exit_pressed():
	return