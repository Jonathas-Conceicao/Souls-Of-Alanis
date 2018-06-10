extends Node

enum AttackType {Slash, Impact, Thrust}

var type   # Attack's type
var damage # Attack's damege
var direction = Vector2()

###
# Constructor
###
func _init(type = Slash, damage = 0, dir_x = -1, dir_y = -1):
	self.type   = type
	self.damage = damage
	self.direction.x = dir_x
	self.direction.y = dir_y
	return self

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
