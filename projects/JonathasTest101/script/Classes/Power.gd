extends Node

var hp
var stamina
var carryLoad
var xp_gain

var cur_hp
var cur_stamina
var cur_carryLoad

var defense

const Defense = preload("Defense.gd")

func _init():
	self.hp        = 1
	self.stamina   = 1
	self.carryLoad = 1
	self.xp_gain   = 1
	self.cur_hp        = self.hp
	self.cur_stamina   = self.stamina
	self.cur_carryLoad = self.carryLoad
	defense = Defense.new(0, 0, 0)

func takeDamage(damage):
	self.cur_hp = min(0.0, self.cur_hp - damage)

func _ready():
	pass

