extends Node

var attributes
var armor
var ring
var weapon
#var trails

const Weapon     = preload("Weapon.gd")
const Attributes = preload("Attributes.gd")
const Armor      = preload("Armor.gd")
const Ring       = preload("Ring.gd")
const Defense    = preload("Defense.gd")
const Attack     = preload("Attack.gd")

func _init():
	attributes = Attributes.new()
	self.add_child(attributes)
	weapon     = Weapon.new(0, Attack.Impact, 1) # Player must always have an weapon
	self.add_child(weapon)
	armor      = null
	ring       = null

func setArmor(armor):
	if armor != null: self.armor.queue_free()
	self.armor = armor

func setRing(ring):
	if ring != null: self.ring.queue_free()	
	self.ring = ring

func setWeapon(weapon):
	self.weapon.queue_free()
	self.weapon = weapon

func genDefense():
	attributes.updatePower()
	var defense = attributes.power.defense.duplicate()
	if armor != null:
		defense = defense.sum(armor.defense)
	if ring  != null:
		defense = defense.sum(ring.power.defense)
	return defense

func genAttack():
	var attack = weapon.genAttack()
	var attAttack = attributes.genAttack(weapon.getAttackType())
	attack.add(attAttack)
	attAttack.queue_free()
	return attack

func takeAttack(attack):
	var defense = getDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	defense.queue_free()
	attributes.takeDamage(damage)
	return damage

func _ready():
	pass
