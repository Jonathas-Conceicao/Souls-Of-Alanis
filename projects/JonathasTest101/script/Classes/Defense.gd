extends Node

var slash
var impact
var thrust

const Attack = preload("Attack.gd")

func _init(s = 0, i = 0, t = 0):
	self.slash  = s
	self.impact = i
	self.thrust = t

func add(defense):
	self.slash  += defense.slash
	self.impact += defense.impact
	self.thrust += defense.thrust

func sum(defense):
	var ret = self.new()
	self.add_child(ret)
	ret.add(self)
	ret.add(defense)
	return ret

func calcCombat(attack):
	var hp = 0
	match attack.type:
		Attack.Slash:
			hp = attack.damage - self.slash
		Attack.Impact:
			hp = attack.damage - self.impact
		Attack.Thrust:
			hp = attack.damage - self.thrust
	return max(hp, 0)

func _ready():
	pass
