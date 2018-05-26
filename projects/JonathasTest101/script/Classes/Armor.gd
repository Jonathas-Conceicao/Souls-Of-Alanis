extends Node

var weight

var defense

const Defense = preload("Defense.gd")

func _init(w = 0, s = 0, i = 0, t = 0):
	defense = Defense.new(s, i, t)
	weight = 0

func _ready():
	pass
