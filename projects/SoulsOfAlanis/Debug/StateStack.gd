tool
extends Panel

func _ready():
	set_as_toplevel(true)

func _on_Player_StateChanged(state):
	var state_names = ""
	var numbers = "->"
	var index = 0
	state_names += state.get_name() + "\n"
	index += 1

	$States.text = state_names
	$Numbers.text = numbers
	return
