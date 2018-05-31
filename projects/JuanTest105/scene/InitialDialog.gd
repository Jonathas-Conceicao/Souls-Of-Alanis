extends Node

func _ready():
	$Sprite/RichTextLabel.show()
	$Sprite.show()

func _process(delta):
	if Input.is_action_just_pressed("ui_attak") || Input.is_action_just_pressed("ui_accept"):
			$Sprite/RichTextLabel.hide()
			$Sprite.hide()
