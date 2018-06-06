extends Node

var hp        # Max HP
var stamina   # Max Stamina
var carryLoad # Max Carry Load
var xp_gain   # XP_Gain

var cur_hp        # Current HP
var cur_stamina   # Current Stamina
var cur_carryLoad # Current CarryLoad

var defense # Defense's instance

const Defense = preload("Defense.gd") # Class reference

###
# Constructor
###
func _init():
	self.hp        = 1
	self.stamina   = 1
	self.carryLoad = 1
	self.xp_gain   = 1
	self.cur_hp        = self.hp
	self.cur_stamina   = self.stamina
	self.cur_carryLoad = self.carryLoad
	defense = Defense.new(0, 0, 0)
	self.add_child(defense)

###
# Causes _damege_ to the current HP
###
func takeDamage(damage):
	self.cur_hp = min(0.0, self.cur_hp - damage)

func _ready():
	pass

