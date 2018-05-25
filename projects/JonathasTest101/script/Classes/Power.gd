extends Node

var hp
var stamina
var carryLoad
var xp_gain

var defense

const Defense = prealod("Defense.gd")

func _init(h = 1, s = 1, c = 1, x = 1):
	self.hp        = h
	self.stamina   = s
	self.carryLoad = c
	self.xp_gain   = x
	defense = Defense.new(0, 0, 0)

func _ready():
	pass

