extends Node

var weight # Armor's weight
var defense # Defense's instance

const Defense = preload("Defense.gd")

###
# Construcotr
# w -> Armor's weight
# s -> Armor's slash defense
# i -> Armor's impact defense
# t -> Armor's thrust defense
###
func _init(w = 0, s = 0, i = 0, t = 0):
	defense = Defense.new(s, i, t)
	self.add_child(defense)
	weight = 0
	return self

###
# return: Armor's weight
###
func getWeight():
	return self.weight
