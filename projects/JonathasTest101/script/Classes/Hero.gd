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
	weapon     = Weapon.new(0, Attack.Impact, 1) # Player must always have an weapon
	armor      = null
	ring       = null

func setArmor(armor):
	self.armor.queue_free()
	self.armor = armor

func setRing(ring):
	self.ring.queue_free()	
	self.ring = ring

func setWeapon(weapon):
	self.weapon.queue_free()
	self.weapon = weapon

func getDefense():
	attributes.updatePower()
	var defense = attributes.power.defense
	if armor != null:
		defense = defense.sum(armor.defense)
	if ring  != null:
		defense = defense.sum(ring.power.defense)
	return defense

func genAttack():
	var attack = weapon.genAttack()
	attack.add(attributes.genAttack(weapon.getAttackType()))
	return attack

func takeAttack(attack):
	var defense = getDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	attributes.takeDamage(damage)
	return damage

func _ready():
	pass
