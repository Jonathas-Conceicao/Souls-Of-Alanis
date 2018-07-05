extends Node

enum Type {Sword, Armor, Ring, Usable}

var InventoryView
var ItemBody
var ItemData

export (Type) var type
export (int, 0, 4) var Sprite_Id
export (String) var Item_Description

func _ready():
	self.set_type(self.type)
	self.set_sprite_id(Sprite_Id)
	$InventoryView.set_description(Item_Description)
	return

func init(data):
	self.ItemData = data
	return

func drop():
	$ItemBody.drop()
	return

func disabled(b):
	self.InventoryView.disabled(b)
	self.ItemBody.disabled(b)
	return

func set_type(t):
	$InventoryView.set_type(t)
	$ItemBody.set_type(t)
	return

func set_sprite_id(i):
	$InventoryView.set_sprite_id(i)
	$ItemBody.set_sprite_id(i + 1)
	return

func get_data():
	return self.ItemData

func _on_ItemBody_picked_up(body):
	if body.has_method("_on_item_pickUp"):
		body._on_item_pickUp(self)
		self.disabled(true)
	return
