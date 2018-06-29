extends Node

func _ready():
	$CameraLimit.set_limits(1.5, 4.2)
	$Player/Camera.update_limits()
	return

func _input(event):
  if event.is_action_pressed("ui_cancel"):
    get_tree().paused = !get_tree().paused
    $Player/Camera2D2/PopupPanel.show()

func _on_Button_pressed():
  $Player/Camera2D/PopupPanel.hide()  
  get_tree().paused = false
  pass # replace with function body
