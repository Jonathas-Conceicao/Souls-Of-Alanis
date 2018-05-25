extends Node

var vitality = 1
var strength = 1
var agility  = 1
var wisdom   = 1

var power

var update = 0

const Power  = preload("Power.gd")
const Attack = preload("Attack.gd")

func _init(v = 1, s = 1, a = 1, w = 1):
	self.vitality = v
	self.strength = s
	self.agility  = a
	self.wisdom   = w
	power = Power.new()
	updatePower()

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
	updatePower()

func updatePower():
	power.hp             = influence(10, 0, 0, 0)
	power.carryLoad      = influence(0, 10, 0, 0)
	power.stamina        = influence(0, 0, 10, 0)
	power.defense.slash  = influence(3, 1, 1, 0)
	power.defense.impact = influence(3, 2, 0, 0)
	power.defense.thrust = influence(3, 0, 2, 0)

func genAttack(attackType):
	var damage = 0
	match attackType:
		Attack.Slash:
			damage = influence(0, 0, 5, 0)
		Attack.Impact:
			damage = influence(0, 5, 0, 0)
		Attack.Thrust:
			damage = influence(0, 2, 2, 0)
	return (Attack.new(attackType, damage))

func takeDamege(damage):
	self.power.hp = int(min(0.0, damage))

func influence(v, s, a, w):
	return ((vitality * v) +
					(strength * s) +
					(agility * a)  +
					(wisdom * w))

func _ready():
	pass

