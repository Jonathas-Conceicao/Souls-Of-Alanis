extends Node

var vitality
var strength
var agility
var wisdom

var level
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
# l -> level
###
func _init(v = 1, s = 1, a = 1, w = 1, l = 0):
	self.vitality = v
	self.strength = s
	self.agility  = a
	self.wisdom   = w
	self.level    = l
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
	self.level += 1
	return

###
# Update de power values
###
func updatePower():
	power.hp             = influence(15, 0, 0, 0)
	power.carryLoad      = influence(0, 10, 0, 0)
	power.stamina        = influence(0, 0, 5, 0)
	power.defense.slash  = influence(0, 1, 1, 0)
	power.defense.impact = influence(0, 2, 0, 0)
	power.defense.thrust = influence(0, 0, 2, 0)
	power.updateCurrent()
	return

###
# Returns a new instance of attack based on the attributes
# attackType -> Attack's type
# return: new Attack instance
###
func genAttack(attackType, dir=null):
	var damage = 0
	match attackType:
		Attack.Slash:
			damage = influence(0, 0, 5, 0)
		Attack.Impact:
			damage = influence(0, 5, 0, 0)
		Attack.Thrust:
			damage = influence(0, 2, 2, 0)
	return (Attack.new(attackType, damage, dir.x if dir else 0, dir.y if dir else 0))

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
# Increases Stamina, bounded by the Max value
# value -> Value to be incremented
###
func increaseStamina(value):
	return self.power.increaseStamina(value);

###
# Decreases Stamina, bounded by the Max value
# value -> Value to be incremented
###
func decreaseStamina(value):
	return self.power.decreaseStamina(value)

###
# Increases HP, bounded by the Max value
# value -> Value to be incremented
###
func increaseHP(value):
	return self.power.increaseHP(value)

###
# Decreases HP, bounded by the Max value
# value -> Value to be decremented
###
func decreaseHP(value):
	return self.power.decreaseHP(value)

###
# Sets a new level
# l -> Level
###
func setLevel(l):
	self.level = l
	return

###
# Get creature's level
###
func getLevel():
	return self.level

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
# return: speed bonus
###
func getSpeedBonus():
	return self.power.getSpeedBonus()

###
# Discounts a value from the HP
# return:
###
func takeDamage(damage):
	self.power.decreaseHP(damage)
	return

###
# Internally used to calculate influence of each attribute
###
func influence(v, s, a, w):
	return ((vitality * v) +
			(strength * s) +
			(agility * a)  +
			(wisdom * w))

