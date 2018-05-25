extends Node

var power

const Power   = preload("Power.gd")
const Defense = preload("Defense.gd")

func _init(h = 0, s = 0, c = 0, x = 0):
	power = Defense.new(h, s, c, x)

func _ready():
	pass
