extends Node

enum AttackType {Slash, Impact, Thrust}

var type
var damage

func _init(type = Slash, damage = 0):
	self.type   = type
	self.damage = damage

func add(attack):
	if attack.type == self.type:
		self.damage += attack.damage

func sum(attack):
	var ret = self.new()
	self.add_child(ret)
	ret.add(self)
	ret.add(attack)
	return ret

func _ready():
	pass
