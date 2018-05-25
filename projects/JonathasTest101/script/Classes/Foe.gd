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

func _init(at = Slash):
	attributes = Attributes.new()
	armor      = null
	ring       = null
	attackType = at

func setArmor(armor):
	self.armor = armor

func setRing(ring):
	self.ring = ring

func genDefense():
	attributes.updatePower()
	var defenseAux = attributes.power.defense.sum(armor.defense)
	var defense = defense.sum(ring.power.defense)
	defenseAux.queue_free()
	return defense

func genAttack():
	return attributes.genAttack()

func takeAttack(attack):
	defense = genDefense()
	damage  = defense.calcCombat(attack)
	attributes.takeDamege(damage)

func _ready():
	pass
