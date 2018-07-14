extends CanvasLayer

enum State {OnGoing, Concluded, Failed}

export (State) var state
export (String) var description

onready var OnGoing = $NPPainel/Container/StatusDisplay/OnGoing
onready var Concluded = $NPPainel/Container/StatusDisplay/Concluded
onready var Failed = $NPPainel/Container/StatusDisplay/Failed

func _ready():
	self.update_text()
	self.update_state()
	return

func set_state(s):
	self.state = s
	return

func set_text(d):
	self.description = d
	return

func update_state():
	OnGoing.visible = false
	Concluded.visible = false
	Failed.visible = false
	match self.state:
		State.OnGoing: OnGoing.visible = true
		State.Concluded: Concluded.visible = true
		State.Failed: Failed.visible = true
	return

func update_text():
	$NPPainel/Container/Message.set_text(self.description)
	return