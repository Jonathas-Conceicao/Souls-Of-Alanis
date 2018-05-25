extends Node

var attributes
var armor
var ring
var attackType

const Attributes = preload("Attributes.gd")
const Armor      = preload("Armor.gd")
const Ring       = preload("Ring.gd")
const Defense    = preload("Defense.gd")
const Attack     = preload("Attack.gd")

func _init(at = Attack.Slash):
	attributes = Attributes.new()
	armor      = null
	ring       = null
	attackType = at

func setArmor(armor):
	self.armor = armor

func setRing(ring):
	self.ring = ring

func getDefense():
	attributes.updatePower()
	var defense = attributes.power.defense
	if armor != null:
		defense = defense.sum(armor.defense)
	if ring  != null:
		defense = defense.sum(ring.power.defense)
	return defense

func genAttack():
	return attributes.genAttack(attackType)

func takeAttack(attack):
	var defense = getDefense()
	var damage  = defense.calcCombat(attack)
	attack.queue_free()
	attributes.takeDamege(damage)
	return damage

func _ready():
	pass
