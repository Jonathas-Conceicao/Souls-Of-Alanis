extends Node

enum Type {Sword, Armor, Ring, Consumable, Scroll}

const InventoryView = preload("res://GUI/InventoryItem.tscn")
const ItemBody = preload("res://Items/ItemBody.tscn")

var ItemData

export (Type) var type
export (int, 0, 4) var Sprite_Id
export (String) var Item_Description
export (int) var uniqueID = -1

func init(t, s, d, uid = -1):
	self.set_type(t)
	self.set_sprite_id(s)
	self.set_description(d)
	self.set_uniqueID(uid)
	return

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
	nIB.connect("picked_up", self, "_on_ItemBody_picked_up")
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
	add_child(data)
	return

func set_uniqueID(nid):
	self.uniqueID = nid
	return

func get_uniqueID():
	return self.uniqueID

func get_data():
	return self.ItemData

func _on_ItemBody_picked_up(ItemBody, body):
	var ok = body._on_item_pickUp(self)
	if ok:
		ItemBody.disabled(true)
		ItemBody.queue_free()
	return
