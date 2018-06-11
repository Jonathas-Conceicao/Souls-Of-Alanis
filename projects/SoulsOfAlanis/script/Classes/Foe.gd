extends Node

var attributes # Creature's attributes
var armor      # Creature's armor (can be null)
var ring       # Creature's ring  (can be null)
var attackType # Creature's Attack's type

const Attributes = preload("Attributes.gd")
const Armor      = preload("Armor.gd")
const Ring       = preload("Ring.gd")
const Defense    = preload("Defense.gd")
const Attack     = preload("Attack.gd")

###
# Constructor
###
func _init(at = Attack.Slash):
	attributes = Attributes.new()
	self.add_child(attributes)
	armor      = null
	ring       = null
	attackType = at
	return self

###
# Increases Stamina, bounded by the Max value
# value -> Value to be incremented
###
func increaseStamina(value):
	return self.attributes.increaseStamina(value);

###
# Decreases Stamina, bounded by the Max value
# value -> Value to be incremented
###
func decreaseStamina(value):
	return self.attributes.decreaseStamina(value)

###
# Increases HP, bounded by the Max value
# value -> Value to be incremented
###
func increaseHP(value):
	return self.attributes.increaseHP(value)

###
# Decreases HP, bounded by the Max value
# value -> Value to be decremented
###
func decreaseHP(value):
	return self.attributes.decreaseHP(value)

###
# Sets a new armor and frees the old one
###
func setArmor(armor):
	if armor != null: self.armor.queue_free()
	self.armor = armor
	return

###
# Sets a new ring and frees the old one
###
func setRing(ring):
	if ring != null: self.ring.queue_free()
	self.ring = ring
	return

###
# return: current carry load
###
func getCarryLoad():
	return self.attributes.getCarryLoad()

###
# return: max carryload
###
func getMaxCarryLoad():
	return self.attributes.getMaxCarryLoad()

###
# return: current HP
###
func getHP():
	return self.attributes.getHP()

###
# return: max HP
###
func getMaxHP():
	return self.attributes.getMaxHP()

###
# return: current Stamina
###
func getStamina():
	return self.attributes.getStamina()

###
# return: max Stamina
###
func getMaxStamina():
	return self.attributes.getMaxStamina()

###
# Generates a new instance of defense based
# on the sum of creature's power and equipaments bonus
# return: new Defense instance
###
func genDefense():
	var defense = attributes.power.defense.duplicate()
	self.add_child(defense)
	if armor != null:
		defense = defense.sum(armor.defense)
	if ring  != null:
		defense = defense.sum(ring.power.defense)
	return defense

###
# Generate's creature's attack based on it's attributes
###
func genAttack():
	return attributes.genAttack(attackType)

###
# Calculates the damege taken, discounts the current HP
# and returns the total damege taken
# return: damege recived
###
func takeAttack(attack):
	var defense = genDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	defense.queue_free()
	attributes.takeDamage(damage)
	return damage
