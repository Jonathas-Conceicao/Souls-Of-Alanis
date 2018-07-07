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
func _init(hp = 1, stamina = 1, carryLoad =1, xp_gain = 1):
	self.hp        = hp
	self.stamina   = stamina
	self.carryLoad = carryLoad
	self.xp_gain   = xp_gain
	self.cur_hp        = self.hp
	self.cur_stamina   = self.stamina
	self.cur_carryLoad = self.carryLoad
	defense = Defense.new(0, 0, 0)
	self.add_child(defense)
	return self

###
# Selts HP`and Stamina back to Max
###
func updateCurrent():
	self.cur_hp = self.hp
	self.cur_stamina = self.stamina
	return

###
# Set stamina to value
# st -> stamina value
###
func setStamina(st):
	self.cur_stamina = max(1, min(st, stamina))
	return

###
# Set HP to value
# st -> stamina value
###
func setHP(st):
	self.cur_hp = max(0, min(st, hp))
	return

###
# Increases Stamina, bounded by the Max value
# value -> Value to be incremented
###
func increaseStamina(value):
	self.setStamina(cur_stamina + value)
	return

###
# Decreases Stamina, bounded by the Max value
# value -> Value to be decremented
###
func decreaseStamina(value):
	self.setStamina(cur_stamina - value)
	return

###
# Increases HP, bounded by the Max value
# value -> Value to be incremented
###
func increaseHP(value):
	self.setHP(cur_hp + value)
	return

###
# Decreases hp, bounded by the Max value
# value -> Value to be decremented
###
func decreaseHP(value):
	self.setHP(cur_hp - value)
	return

###
# return: current HP
###
func getHP():
	return self.cur_hp

###
# return: max HP
###
func getMaxHP():
	return self.hp

###
# return: current Stamina
###
func getStamina():
	return self.cur_stamina

###
# return: max Stamina
###
func getMaxStamina():
	return self.stamina
