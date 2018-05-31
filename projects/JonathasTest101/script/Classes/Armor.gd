extends Node

var weight

var defense

const Defense = preload("Defense.gd")

func _init(w = 0, s = 0, i = 0, t = 0):
	defense = Defense.new(s, i, t)
	self.add_child(defense)
	weight = 0

func getWeight():
	return self.weight

func _ready():
	pass
