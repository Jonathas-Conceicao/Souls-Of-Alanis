extends Node

var attributes # Hero's attributes
var armor      # Hero's current Armor
var ring       # Hero's current Ring
var weapon     # Hero's current Weapon
#var trails

const Weapon     = preload("Weapon.gd")
const Attributes = preload("Attributes.gd")
const Armor      = preload("Armor.gd")
const Ring       = preload("Ring.gd")
const Defense    = preload("Defense.gd")
const Attack     = preload("Attack.gd")

###
# Constructor
###
func _init():
	attributes = Attributes.new()
	self.add_child(attributes)
	weapon     = Weapon.new(0, Attack.Impact, 1) # Player must always have an weapon
	self.add_child(weapon)
	armor      = null
	ring       = null
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
# Equips a new Armor if the weight allows it and
# frees the old Armor if needed
# return: True if successful
#---------False otherwise
###
func setArmor(armor):
	var ok
	var curW = 0 if self.armor == null else self.armor.weight
	ok = self.attributes.trySwap(curW, armor.weight)
	if ok:
		self.armor = armor
	return ok

###
# Equips a new Ring and
# frees the old one if needed
# return: True (Always)
###
func setRing(ring):
	self.ring = ring
	return true

###
# Equips a new Weapon if the weight allows it and
# frees the old Weapon
# return: True if successful
#---------False otherwise
###
func setWeapon(weapon):
	var ok
	var curW = 0 if self.weapon == null else self.weapon.weight
	ok = self.attributes.trySwap(self.weapon.weight, weapon.weight)
	if ok:
		self.weapon = weapon
	return ok

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

# Calculates the real defense of the Hero
# based on requipaments and attributes
# return: new Defense's instance
###
func genDefense():
	var defense = attributes.power.defense.duplicate()
	if armor != null:
		defense = defense.sum(armor.defense)
	if ring  != null:
		defense = defense.sum(ring.power.defense)
	return defense

###
# Generates a new instance of Attack base on
# attributes and the current weapon
# return: new Attack's instance
###
func genAttack():
	var attack = weapon.genAttack()
	var attAttack = attributes.genAttack(weapon.getAttackType())
	attack.add(attAttack)
	attAttack.queue_free()
	return attack

###
# Calculates the damege of the _attack_,
# discounts from the current HP and
# returns the damege taken
# return: damege take
###
func takeAttack(attack):
	var defense = genDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	defense.queue_free()
	attributes.takeDamage(damage)
	return damage

###
# Increace Hero's level by one
###
func levelUp():
	self.attributes.increment()
	return
