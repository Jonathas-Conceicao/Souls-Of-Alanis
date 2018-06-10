extends Node

var vitality  
var strength
var agility
var wisdom
var update = 0 # Used for the clock lvl up

var power # Attribute's Power instance

const Power  = preload("Power.gd")  # Class reference
const Attack = preload("Attack.gd") # Class reference

###
# Constructor
# v -> vitalidade
# s -> strength
# a -> agility
# w -> wisdom
###
func _init(v = 1, s = 1, a = 1, w = 1):
	self.vitality = v
	self.strength = s
	self.agility  = a
	self.wisdom   = w
	power = Power.new()
	self.add_child(power)
	updatePower()
	return self

###
# Increments the attributes in clock
# n -> number of level ups
###
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
	return

###
# Update de power values
###
func updatePower():
	power.hp             = influence(10, 0, 0, 0)
	power.carryLoad      = influence(0, 10, 0, 0)
	power.stamina        = influence(0, 0, 10, 0)
	power.defense.slash  = influence(3, 1, 1, 0)
	power.defense.impact = influence(3, 2, 0, 0)
	power.defense.thrust = influence(3, 0, 2, 0)
	power.updateCurrent()
	return

###
# Returns a new instance of attack based on the attributes
# attackType -> Attack's type
# return: new Attack instance
###
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

###
# Tries to change an item based on it's weight
# cur_w -> weight of the currently equipped item
# new_w -> weight of the item to be equipped
# return: True if successeful
#          False otherwise
###
func trySwap(cur_w, new_w):
	var tCarryLoad = self.power.cur_carryLoad
	tCarryLoad -= cur_w
	tCarryLoad += new_w
	if tCarryLoad <= power.carryLoad:
		power.cur_carryLoad = tCarryLoad
		return true
	return false

###
# Set stamina tu value
# st -> stamina value
###
func setStamina(st):
	self.power.setStamina(st)
	return

###
# return: the current carry load
###
func getCarryLoad():
	return self.power.cur_carryLoad

###
# return: the maximum carry load
###
func getMaxCarryLoad():
	return self.power.carryLoad

###
# return: current HP
###
func getHP():
	return self.power.getHP()

###
# return: max HP
###
func getMaxHP():
	return self.power.getMaxHP()

###
# return: current Stamina
###
func getStamina():
	return self.power.getStamina()

###
# return: max Stamina
###
func getMaxStamina():
	return self.power.getMaxStamina()

###
# Discounts a value from the HP
# return:
###
func takeDamage(damage):
	self.power.takeDamage(damage)

###
# Internally used to calculate influence of each attribute
###
func influence(v, s, a, w):
	return ((vitality * v) +
			(strength * s) +
			(agility * a)  +
			(wisdom * w))

