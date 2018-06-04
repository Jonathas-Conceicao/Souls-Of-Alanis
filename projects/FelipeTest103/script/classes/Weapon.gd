extends Node

var weight # Weapon's weight
var damage # Weapon's base damege
var damageType #Weapons damege type

const Attack = preload("Attack.gd")

###
# return: Weapon's attack type
###
func getAttackType():
	return (self.damageType)

###
# return: Weapon's weigth
###
func getWeight():
	return self.weight

###
# Constructor
###
func _init(w = 0, t = Attack.Slash, d = 1):
	weight = w
	damageType = t
	damage = d

###
# return: new Attack's instance
###
func genAttack():
	return (Attack.new(damageType, damage))

func _ready():
	pass
