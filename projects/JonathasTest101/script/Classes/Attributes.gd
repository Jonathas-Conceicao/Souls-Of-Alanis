extends Node

var vitality = 1
var strength = 1
var agility  = 1
var wisdom   = 1

var power

var update = 0

const Power = preload("Power.gd")

func _ready():
	pass

func _init():
	power = Power.new()
	updatePower(power)

func increment(n=1):
	for i in range(n):
		match update:
			0:
				self.vitality += 1
			1:
				self.strength += 1
			2:
				self.agility  += 1
			3:
				self.wisdom   += 1
		update = (update+1) % 4

func updatePower(power):
	power.hp             = influence(10, 0, 0, 0)
	power.carryLoad      = influence(0, 10, 0, 0)
	power.stamina        = influence(0, 0, 10, 0)
	power.defense_slash  = influence(6, 2, 2, 0)
	power.defense_impact = influence(6, 4, 0, 0)
	power.defense_thrust = influence(6, 0, 4, 0)

func influence(v, s, a, w):
	return ((vitality * v) +
					(strength * s) +
					(agility * a)  +
					(wisdom * w))

