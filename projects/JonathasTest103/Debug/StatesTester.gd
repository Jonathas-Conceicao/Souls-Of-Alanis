extends CanvasLayer

func _ready():
	pass

func _on_Player_StateChanged(states_stack):
	return $StateStack._on_Player_StateChanged(states_stack)
	