extends "res://Items/Item.gd"

const Item = preload("res://Items/Item.gd")
const Armor = preload("res://script/Classes/Armor.gd")

# Data values
const WEIGHT = 3
const SLASH  = 5
const IMPACT = 5
const THRUST = 5

# Sprite values
const DESCRIPTION = "A basic aromor"
const SPRITE_ID = 0

func _ready():
	self.set_values()
	return

func set_values():
	self.set_type(Item.Type.Armor)
	self.set_sprite_id(self.SPRITE_ID)
	self.set_description(self.DESCRIPTION)
	self.set_data(self.gen_data()) # Set's data as child of Item
	return

func gen_data():
	var equipData = Armor.new(self.WEIGHT,
							  self.SLASH,
							  self.IMPACT,
							  self.THRUST)
	return equipData


