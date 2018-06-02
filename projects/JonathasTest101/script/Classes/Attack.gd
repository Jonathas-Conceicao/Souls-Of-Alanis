extends Node

enum AttackType {Slash, Impact, Thrust}

var type   # Attack's type
var damage # Attack's damege

###
# Constructor
###
func _init(type = Slash, damage = 0):
	self.type   = type
	self.damage = damage

###
# Adds the current damege to the damege of another Attack of the same type
# attack -> another instance
###
func add(attack):
	if attack.type == self.type:
		self.damage += attack.damage

###
# Returns a Attack that's the sum of this Attack with another one
# attack -> another instance
# return: new instance
###
func sum(attack):
	var ret = self.new()
	self.add_child(ret)
	ret.add(self)
	ret.add(attack)
	return ret

func _ready():
	pass
