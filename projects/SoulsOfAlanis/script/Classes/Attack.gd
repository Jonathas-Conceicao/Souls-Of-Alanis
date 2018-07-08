extends Node

enum AttackType {Slash, Impact, Thrust}

var type   # Attack's type
var damage # Attack's damage
var direction = Vector2() # Normal vector of the Attack's direction

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
# Adds the current damage to the damage of another Attack of the same type
# attack -> another instance
###
func add(attack):
	if attack.type == self.type:
		self.damage += attack.damage
	return

###
# Adds the current damage to the damage of another Attack, regardless of the type
# attack -> another instance
###
func forceAdd(attack):
	self.damage += attack.damage
	return

###
# Returns a Attack that's the sum of this Attack with another one
# attack -> another instance
# return: new instance
###
func sum(attack):
	var ret = self.duplicate() # This dosn't copy internal state
	self.add_child(ret)
	ret.add(self)
	ret.add(attack)
	return ret
