extends CanvasLayer

enum POSITION {Up, Down}
export(POSITION) var Position = 0
export var HIGHT = 180
export var NUMBER_CHAR = 305
export var MARGIN = 10

signal finished_dialog

func _ready():
	$NPPainel/RedButton.visible = false
	$NPPainel/GreenButton.visible = true
	self.update_position()
	return

func update_position():
	$NPPainel.set_margin(0, self.MARGIN)
	$NPPainel.set_margin(2, - self.MARGIN)
	if Position == POSITION.Up:
		$NPPainel.set_anchor(1, 0, false, true)
		$NPPainel.set_anchor(3, 0, false, true)
		$NPPainel.set_margin(1, self.MARGIN)
		$NPPainel.set_margin(3, (self.HIGHT + self.MARGIN))
	else:
		$NPPainel.set_anchor(1, 1, false, true)
		$NPPainel.set_anchor(3, 1, false, true)
		$NPPainel.set_margin(1, - (self.HIGHT + self.MARGIN))
		$NPPainel.set_margin(3, - self.MARGIN)
	return

func set_speaker(name):
	$NPPainel/Title.set_text(name + ":")
	return
