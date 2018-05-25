extends Node

enum AttackType {Slash, Impact, Thrust}

var type
var damage

func _init(type = Slash, damage = 0):
	self.type   = type
	self.damage = damage

func increment(attack):
	if attack.type == self.type:
		self.damage += attack.damage


func _ready():
	pass
