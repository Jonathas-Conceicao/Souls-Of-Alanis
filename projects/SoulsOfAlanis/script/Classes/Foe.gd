extends Node

enum FoeType {Air, Ground, Wall, Special}

var attributes # Creature's attributes
var armor      # Creature's armor (can be null)
var ring       # Creature's ring  (can be null)
var attackType # Creature's Attack's type
var type       # Creature's type

var xp_points # Experience points given by then Foe upon death

const Attributes = preload("Attributes.gd")
const Armor      = preload("Armor.gd")
const Ring       = preload("Ring.gd")
const Defense    = preload("Defense.gd")
const Attack     = preload("Attack.gd")

###
# Constructor
###
func _init(at = Attack.Slash, tp = FoeType.Ground, xp = 1):
	attributes = Attributes.new()
	self.add_child(attributes)
	armor      = null
	ring       = null
	attackType = at
	type       = tp
	self.xp_points = xp
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
	self.armor = armor
	return

###
# Sets a new ring and frees the old one
###
func setRing(ring):
	self.ring = ring
	return

###
# Sets the XP points to be given upon death
###
func setXP(xp):
	self.xp_points = xp

###
# return: XP points given
###
func getXP():
	return self.xp_points

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
# return: Foe's type
###
func getType():
	return self.type

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
func genAttack(dir=null):
	return attributes.genAttack(attackType, dir)

###
# Calculates the damage taken, discounts the current HP
# and returns the total damage taken
# return: damage recived
###
func takeAttack(attack):
	var defense = genDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	defense.queue_free()
	attributes.takeDamage(damage)
	return damage
