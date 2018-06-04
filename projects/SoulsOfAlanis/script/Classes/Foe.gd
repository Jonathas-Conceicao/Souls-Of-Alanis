extends Node

enum FoeType {Air, Ground, Wall, Special} 

var attributes # Creature's attributes
var armor      # Creature's armor (can be null)
var ring       # Creature's ring  (can be null)
var attackType # Creature's Attack's type
var type       # Creature's type

const Attributes = preload("Attributes.gd")
const Armor      = preload("Armor.gd")
const Ring       = preload("Ring.gd")
const Defense    = preload("Defense.gd")
const Attack     = preload("Attack.gd")

###
# Constructor
###
func _init(at = Attack.Slash, tp = Ground):

	self.attributes = Attributes.new()
	self.add_child(attributes)
	self.armor      = null
	self.ring       = null
	self.attackType = at
	self.type       = tp

###
# Sets a new armor and frees the old one
###
func setArmor(armor):
	if armor != null: self.armor.queue_free()
	self.armor = armor

###
# Sets a new ring and frees the old one
###
func setRing(ring):
	if ring != null: self.ring.queue_free()
	self.ring = ring

###
# Generates a new instance of defense based
# on the sum of creature's power and equipaments bonus
# return: new Defense instance
###
func genDefense():
	attributes.updatePower()
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

func get_size():
	get_parent().get_node("Pivot").get_node("Body").region_rect.size

func _ready():
	pass
