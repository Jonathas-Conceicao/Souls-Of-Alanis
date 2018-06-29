extends Node

const L = 900 # Screen length
const H = 700 # Screen hight

func _ready():
	set_limits(1,1)
	pass

###
# Set the screen limits based on the units of screen size
# i -> number of lines of screen size
# j -> number of columns of screen size
###
func set_limits(i = 1, j = 1):
	var full_h = H * i
	var full_l = L * j 
	var half_h = (H * i) / 2
	var half_l = (L * j) / 2
	$Left.set_position(Vector2(0, half_h))
	$Top.set_position(Vector2(half_l, 0))
	$Right.set_position(Vector2(full_l, half_h))
	$Bottom.set_position(Vector2(half_l, full_h))
	return
