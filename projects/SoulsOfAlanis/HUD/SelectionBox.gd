extends "res://HUD/DialogBox.gd"

const ArrowTexture = preload("art/Selection_Arrow.png")

# var itemList = []

func _ready():
	add_item("sus")
	add_item("pei")
	add_item("to")
	add_item("otário")

func add_item(text):
	$NPPainel/ItemList.add_item(text, ArrowTexture, true)
	return
