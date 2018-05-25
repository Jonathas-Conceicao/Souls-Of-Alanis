extends Node

var weight
var damage
var damageType

const Attack = preload("Attack.gd")

func _init(w = 0, t = Attack.Slash, d = 1):
	weight = w
	damageType = t
	damage = d

func genAttack():
	return (Attack.new(damageType, damage))

func getAttackType():
	return (self.damageType)

func _ready():
	pass
