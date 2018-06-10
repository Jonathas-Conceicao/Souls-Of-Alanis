extends Node

var power # Ring's power bonus

const Power   = preload("Power.gd")
const Defense = preload("Defense.gd")

###
# Constructor
# hp -> Ring's HP bonus
# st -> Ring's Stamina bonus
# cl -> Ring's Carry Load bonus
# xp -> Ring's XP bonus
# s  -> Ring's slash defense bonus
# i  -> Ring's impact defense bonus
# t  -> Ring's thrust defense bonus
###
func _init(hp = 0, st = 0, cl = 0, xp = 0, s = 0, i = 0, t = 0):
	power = Power.new(hp, st, cl, xp)
	self.add_child(power)
	power.defense.slash  = s
	power.defense.impact = i
	power.defense.thrust = t
	return self
