extends Node

var slash
var impact
var thrust

const Attack = preload("Attack.gd")

###
# Construcotr
###
func _init(s = 0, i = 0, t = 0):
	self.slash  = s
	self.impact = i
	self.thrust = t

###
# Sums this instance with another
# defense -> another instance
###
func add(defense):
	self.slash  += defense.slash
	self.impact += defense.impact
	self.thrust += defense.thrust

###
# Returns a new instance that the some of this with the other
# defense -> another innstance
# return: new instance
###
func sum(defense):
	var ret = self.new()
	self.add_child(ret)
	ret.add(self)
	ret.add(defense)
	return ret


###
# Calculates the damege caused by a attack to this defense
# attack -> Attack instance
# return: damege (>=0)
###
func calcCombat(attack):
	var damege = 0
	match attack.type:
		Attack.Slash:
			damege = attack.damage - self.slash
		Attack.Impact:
			damege = attack.damage - self.impact
		Attack.Thrust:
			damege = attack.damage - self.thrust
	return max(damege, 0)

func _ready():
	pass
