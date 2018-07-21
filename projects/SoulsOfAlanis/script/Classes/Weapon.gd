extends Node

var weight # Weapon's weight
var damage # Weapon's base damage
var damageType #Weapons damage type

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
	return self

###
# return: new Attack's instance
###
func genAttack(dir = null):
	if dir:
		return Attack.new(self.damageType, self.damage, dir.x, dir.y)
	return Attack.new(self.damageType, self.damage)
