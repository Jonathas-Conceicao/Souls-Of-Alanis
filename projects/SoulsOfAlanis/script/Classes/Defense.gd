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
	return self

###
# Overload the duplicate method to copy the internal state
###
func duplicate():
	var newDefense = .duplicate()
	newDefense.slash = self.slash
	newDefense.impact = self.impact
	newDefense.thrust = self.thrust
	return newDefense

###
# Sums this instance with another
# defense -> another instance
###
func add(defense):
	self.slash  += defense.slash
	self.impact += defense.impact
	self.thrust += defense.thrust
	return

###
# Returns a new instance that is the sum of this with the other
# defense -> another innstance
# return: new instance
###
func sum(defense):
	var ret = self.duplicate() # This dosn't copy internal state
	self.add_child(ret)
	ret.add(self)
	ret.add(defense)
	return ret

###
# Calculates the damage caused by a attack to this defense
# attack -> Attack instance
# return: damage (>=0)
###
func calcCombat(attack):
	var damage = 0
	match attack.type:
		Attack.Slash:
			damage = attack.damage - self.slash
		Attack.Impact:
			damage = attack.damage - self.impact
		Attack.Thrust:
			damage = attack.damage - self.thrust
	return max(damage, 0)
