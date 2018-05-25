extends Node

var slash
var impact
var thrust

func _init(s = 0, i = 0, t = 0):
	self.slash  = s
	self.impact = i
	self.thrust = t

func increrment(defense):
	self.slash  += defense.slash
	self.impact += defense.impact
	self.thrust += defense.thrust

func _ready():
	pass
