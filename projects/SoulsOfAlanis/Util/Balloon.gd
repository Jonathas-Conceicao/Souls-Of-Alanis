extends Sprite

const X_BALLOON = 3
const HEART_BALLOON = 6
const TRIPLE_DOT_BALLOON = 13
const EXCLAMATION_BALLOON = 21
const INTERROGATION_BALLOON = 29

export (int, 0, 31) var balloon = 13

func _ready():
	self.update()
	return

func enabled(b):
	self.visible = b
	return

###
# Selects a ballon sprite, see defines for usual values
###
func selectBallon(v):
	self.ballon = v
	return

func update():
	var i = 32 * (self.balloon % 8)
	var j = 32 * int(self.balloon/8)
	self.set_region_rect(Rect2(Vector2(i, j), Vector2(32, 32)))
	return