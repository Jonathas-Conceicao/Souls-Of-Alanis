extends "res://GUI/DialogBox.gd"

const ItemSelection = preload("ItemSelection.tscn")

var itemList
var selected

func test_ready():
	self.set_dialog("Speaker", "A long text telling a how story about the amazing number of options you can  choose in this dialog box")
	self.add_item("Yes")
	self.add_item("No")
	self.add_item("Maybe")
	self.add_item("No way, hosay!")
	self.enabeled(true)
	return

func _ready():
	self.update_selected()

	# self.test_ready()
	return

func showItens():
	$NPPainel/ItemList.visible = true
	self.update_selected()
	return

func _input(event):
	if event.is_action_pressed("ui_right"):
		self.select_next_item()
	elif event.is_action_pressed("ui_left"):
		self.select_prev_item()
	return

func update_selected():
	self.itemList = $NPPainel/ItemList.get_children()
	if self.itemList:
		self.itemList[0].selected(true)
	self.selected = 0
	return

func select_next_item():
	var limit = itemList.size()
	if limit == 0:
		return
	var n = (selected + 1) % limit
	itemList[self.selected].selected(false)
	itemList[n].selected(true)
	self.selected = n
	return

func select_prev_item():
	var limit = itemList.size()
	if limit == 0:
		return
	var n = (selected - 1 + limit) % limit
	itemList[self.selected].selected(false)
	itemList[n].selected(true)
	self.selected = n
	return

func select_current_item():
	emit_signal("finished_dialog", self, selected)
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

func _on_SelectionBox_finished_dialog(obj):
	if $NPPainel/ItemList.visible:
		print("Option selected: ", self.selected)
		self.select_current_item()
	else:
		self.showItens()
	return
