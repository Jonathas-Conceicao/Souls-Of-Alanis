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

###
# Set stamina tu value
# st -> stamina value
###
func setStamina(st):
	self.attributes.setStamina(st)

###
# Equips a new Armor if the weight allows it and
# frees the old Armor if needed
# return: True if successful
#---------False otherwise
###
func setArmor(armor):
	var s
	if armor != null:
		s = self.attributes.trySwap(self.armor.weight, armor.weight)
	else:
		s = self.attributes.trySwap(0, armor.weight)
	if s:
		if armor != null: self.armor.queue_free()
		self.armor = armor
	return s

###
# Equips a new Ring and
# frees the old one if needed
###
func setRing(ring):
	if ring != null: self.ring.queue_free()
	self.ring = ring

###
# Equips a new Weapon if the weight allows it and
# frees the old Weapon
# return: True if successful
#---------False otherwise
###
func setWeapon(weapon):
	var s
	s = self.attributes.trySwap(self.weapon.weight, weapon.weight)
	if s:
		self.weapon.queue_free()
		self.weapon = weapon
	return s

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
	attributes.updatePower()
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

func _ready():
	pass
