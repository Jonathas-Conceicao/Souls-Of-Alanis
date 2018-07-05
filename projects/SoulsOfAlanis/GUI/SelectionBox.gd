extends "res://GUI/DialogBox.gd"

const ItemSelection = preload("ItemSelection.tscn")

var itemList
var selected

func _ready():
	self.itemList = $NPPainel/ItemList.get_children()
	self.itemList[0].selected(true)
	self.selected = 0
	return

func _input(event):
	if event.is_action_pressed("ui_right"):
		self.select_next_item()
	elif event.is_action_pressed("ui_left"):
		self.select_prev_item()
	elif event.is_action_pressed("ui_accept"):
		self.select_current_item()
	return

func select_next_item():
	var limit = itemList.size()
	var n = (selected + 1) % limit
	itemList[self.selected].selected(false)
	itemList[n].selected(true)
	self.selected = n
	return

func select_prev_item():
	var limit = itemList.size()
	var n = (selected - 1 + limit) % limit
	itemList[self.selected].selected(false)
	itemList[n].selected(true)
	self.selected = n
	return

func select_current_item():
	emit_signal("finished_dialog", self, selected)
	clear_items()
	return

func add_item(text):
	var item = ItemSelection.instance()
	item.set_text(text)
	item.selected(false)
	$NPPainel/ItemList.add_child(item)
	return

func clear_items():
	for item in $NPPainel/ItemList.get_children():
		item.queue_free()
	return
