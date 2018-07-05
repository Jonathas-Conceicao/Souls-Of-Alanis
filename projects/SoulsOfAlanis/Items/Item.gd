extends Node

var InventoryView
var ItemBody
var ItemData

func _ready():
	pass

func init(iv, ib, id):
	self.InventoryView = iv
	self.ItemBody = ib
	self.ItemData = id
	return
