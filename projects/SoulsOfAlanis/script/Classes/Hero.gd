extends Node

var attributes # Hero's attributes
var armor      # Hero's current Armor
var ring       # Hero's current Ring
var weapon     # Hero's current Weapon

var xp_points
var cur_xp_points

var damageBonus = null # Attack instance for direct damage bonus to all attacks

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
	weapon     = Weapon.new(0, Attack.Impact, 1) # Hero must always have an weapon
	self.add_child(weapon)
	armor      = null
	ring       = null
	self.xp_points = 10
	self.cur_xp_points = 0
	return self

func clean():
	self.armor = null
	self.ring = null
	self.weapon = Weapon.new(0, Attack.Impact, 1) # Player must always have an weapon
	self.attributes.updatePower()
	self.attributes.power.cur_carryLoad = 0
	return


###
# Checks if there's enough stamina for an Attack, and if so, consumes it
###
func tryAttack():
	var cost = self.attackCost()
	if cost > self.getStamina():
		return false
	self.decreaseStamina(cost)
	return true

func attackCost():
	return self.weapon.getWeight() if weapon != null else 5

func calcPercentage(h, l):
	return ((l*100)/h)/100.0

func increaseXP(value):
	self.cur_xp_points += value + self.attributes.wisdom
	return

func storedLevels():
	return int(self.cur_xp_points/self.xp_points)

###
# Increace Hero's level by one
###
func levelUp(selectedAttribute):
	# Update XP points
	self.cur_xp_points -= self.xp_points
	self.setLevel(self.getLevel() + 1)
	match selectedAttribute:
		0:
			self.attributes.vitality += 1
		1:
			self.attributes.strength += 1
		2:
			self.attributes.agility  += 1
		3:
			self.attributes.wisdom   += 1
		_:
			pass
	self.attributes.updatePower()
	return

###
# Increases Stamina, bounded by the Max value
# value -> Value to be incremented
###
func increaseStamina(value):
	return self.attributes.increaseStamina(value);

###
# Decreases Stamina, bounded by the min value
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
# Sets a new level for the Hero (unsed only for display)
# l -> Level
###
func setLevel(l):
	self.attributes.setLevel(l)
	return

###
# Get Hero's level
###
func getLevel():
	return self.attributes.getLevel()

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
# return: speed bonus
###
func getSpeedBonus():
	return self.attributes.getSpeedBonus()

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
func genAttack(dir=null):
	var attack = weapon.genAttack(dir)
	var attAttack = attributes.genAttack(weapon.getAttackType())
	# add_child(attack)
	attack.add(attAttack)
	if damageBonus != null:
		attack.forceAdd(damageBonus)
	attAttack.queue_free()
	return attack

###
# Sets damage bonus instance
# attack -> Attack instance, null for disabled
###
func set_damageBonus(attack):
	self.damageBonus = attack
	return

###
# Calculates the damage of the _attack_,
# discounts from the current HP and
# returns the damage taken
# return: damage take
###
func takeAttack(attack):
	var defense = genDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	defense.queue_free()
	attributes.takeDamage(damage)
	return damage
