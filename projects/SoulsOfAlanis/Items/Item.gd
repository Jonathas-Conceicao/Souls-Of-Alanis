extends Node

enum Type {Sword, Armor, Ring, Consumable}

const InventoryView = preload("res://GUI/InventoryItem.tscn")
const ItemBody = preload("res://ItemsBody/ItemBody.tscn")

var ItemData

export (Type) var type
export (int, 0, 4) var Sprite_Id
export (String) var Item_Description

func gen_InventoryView():
	var nIV = InventoryView.instance()
	nIV.set_type(self.type)
	nIV.set_sprite_id(self.Sprite_Id)
	nIV.set_description(self.Item_Description)
	return nIV

func gen_ItemBody():
	var nIB = ItemBody.instance()
	nIB.set_type(self.type)
	nIB.set_sprite_id(self.Sprite_Id)
	return nIB

func set_type(t):
	self.type = t
	return

func set_sprite_id(i):
	self.Sprite_Id = i
	return

func set_description(d):
	self.Item_Description = d
	return

func set_data(data):
	self.ItemData = data
	return

func get_data():
	return self.ItemData

func _on_ItemBody_picked_up(body):
	if body.has_method("_on_item_pickUp"):
		body._on_item_pickUp(self)
		self.disabled(true)
	return
