extends Node

var power

const Power   = preload("Power.gd")
const Defense = preload("Defense.gd")

func _init(hp = 0, st = 0, cl = 0, xp = 0, s = 0, i = 0, t = 0):
	power = Power.new(hp, st, cl, xp)
	power.defense.slash  = s
	power.defense.impact = i
	power.defense.thrust = t


func _ready():
	pass
