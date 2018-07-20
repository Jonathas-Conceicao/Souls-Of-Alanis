extends "res://Items/Item.gd"

const Item = preload("res://Items/Item.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")

# Data values
const WEIGHT = 3
const DAMAGE = 5

# Sprite values
const DESCRIPTION = "A basic sword"
const SPRITE_ID = 0

func _ready():
	self.set_values()
	return

func set_values():
	self.set_type(Item.Type.Sword)
	self.set_sprite_id(self.SPRITE_ID)
	self.set_description(self.DESCRIPTION)
	self.set_data(self.gen_data()) # Set's data as child of Item
	return

func gen_data():
	var equipData = Weapon.new(self.WEIGHT, 0, self.DAMAGE)
	return equipData

