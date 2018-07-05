extends "MenuItem.gd"

const InventoryItem  = preload("InventoryItem.tscn")
const InventoryItemS = preload("InventoryItem.gd")

enum Direction {Left, Right, Up, Down}
enum States {Browse, Action}

const COLUMNS = 5
const LINES   = 3

var state = Browse
var selected = [0, 0]
var itemSelected
var itemList = []

var bSelected = 0

func _input(event):
	if   event.is_action_pressed("ui_right"):
		if state == Browse:
			self.browse_move(Right)
		else:
			self.buttom_move(Right)
	elif event.is_action_pressed("ui_left"):
		if state == Browse:
			self.browse_move(Left)
		else:
			self.buttom_move(Left)
	elif event.is_action_pressed("ui_up"):
		if state == Browse:
			self.browse_move(Up)
		else:
			self.buttom_move(Up)
	elif event.is_action_pressed("ui_down"):
		if state == Browse:
			self.browse_move(Down)
		else:
			self.buttom_move(Down)
	elif event.is_action_pressed("ui_accept"):
		if state == Action && (bSelected == 0 || bSelected == 1):
			emit_signal("finished_interaction", self, bSelected, self.get_selected_as_index())
		self.state_change()
	elif event.is_action_pressed("ui_cancel"):
		if state == Browse:
			emit_signal("finished_interaction", self, -1, -1)
		self.state_change()
	return

func test_ready():
	var i1 = InventoryItem.instance()
	var i2 = InventoryItem.instance()
	var i3 = InventoryItem.instance()
	var i4 = InventoryItem.instance()
	var i5 = InventoryItem.instance()
	var i6 = InventoryItem.instance()

	var e1 = InventoryItem.instance()

	i1.init(InventoryItemS.Type.Sword , "A basic sword"  , 0, null)
	i2.init(InventoryItemS.Type.Armor , "A basic aromor" , 0, null)
	i3.init(InventoryItemS.Type.Ring  , "A red ring"     , 3, null)
	i4.init(InventoryItemS.Type.Sword , "A prety Potion" , 4, null)
	i5.init(InventoryItemS.Type.Ring  , "Another Ring"   , 1, null)
	i6.init(InventoryItemS.Type.Ring  , "A ring with a really, really, reaaaly long description for testing", 0, null)

	e1.init(InventoryItemS.Type.Sword , "The Starter Sword", 2, null)

	var exItemList = [i1, i2, i3, i4, i5, i6]
	self.init(exItemList, [null, e1, null, null])
	return

func _ready():
	self.selection_reset()
	self.buttom_reset()

	# self.test_ready()
	return

func init(invList, equipList):
	self.itemList = invList
	self.display_items()
	self.display_equipaments(equipList)
	self.update_selected()
	self.update_description()
	self.selection_visible(true)
	return

func state_change():
	if state == Browse:
		# Leaving Browse state
		# self.selection_reset()
		# self.selection_visible(false)

		# Entering Action state
		$Background/Buttoms.get_children()[bSelected].set_selected(true)
		self.state = Action
	else:
		# Leaving Action state
		self.buttom_reset()
		#Entering Browse state
		self.selection_visible(true)
		self.state = Browse
	return

func browse_move(direction):
	match direction:
		Up:
			selected[0] += LINES   - 1
		Down:
			selected[0] += 1
		Left:
			selected[1] += COLUMNS - 1
		Right:
			selected[1] += 1
	selected[0] %= LINES
	selected[1] %= COLUMNS
	set_item_pos($Background/ItemSelector, selected[0], selected[1])
	self.update_selected()
	self.update_description()
	return

func buttom_move(direction):
	var list = $Background/Buttoms.get_children()
	var sz = list.size()
	list[bSelected].set_selected(false)
	match direction:
		Right, Down:
			bSelected += 1
		Left, Up:
			bSelected += sz - 1
	bSelected %= sz
	list[bSelected].set_selected(true)
	return

func selection_reset():
	self.selected[0] = 0
	self.selected[1] = 0
	self.set_item_pos($Background/ItemSelector, selected[0], selected[1])
	return

func buttom_reset():
	for buttom in $Background/Buttoms.get_children():
		buttom.set_selected(false)
	self.bSelected   = 0
	return

func selection_visible(b):
	$Background/ItemSelector.visible = b
	return

func get_selected_as_index():
	return selected[1] + (selected[0] * COLUMNS)

func update_selected():
	var index = self.get_selected_as_index()
	self.itemSelected = null if index >= itemList.size() else itemList[index]
	return

func update_description():
	var text
	if self.itemSelected == null:
		text = ""
	else:
		text = itemSelected.get_description()
	$Background/Description.set_text(text)
	return

func display_items():
	var i = 0
	var j = 0
	for item in itemList:
		$Background.add_child_below_node($Background/InitialPosition, item)
		self.set_item_pos(item, i, j)
		j = (j + 1)
		i = int(j /  5)
		j %= COLUMNS
	return

func display_equipaments(list):
	var posList = $Background/EquipPositions.get_children()
	var item
	var pos
	for i in range(0, posList.size()):
		item = list[i]
		pos  = posList[i]
		if item != null:
			$Background.add_child_below_node($Background/EquipPositions, item)
			item.set_position(pos.get_position())
	return

const CELL_SIZE  = 16 * 3
const CELL_SPACE = 1  * 3

func set_item_pos(obj, i, j):
	var basePosition = $Background/InitialPosition.get_position()
	basePosition.x += (j * (CELL_SIZE + CELL_SPACE))
	basePosition.y += (i * (CELL_SIZE + CELL_SPACE))
	obj.set_position(basePosition)
	return

func _on_Inventory_finished_interaction(obj, action, index):
	if action >= 0:
		var ac = "Use" if action == 0 else "Drop"
		print(ac, " item", index)
	else:
		print("Inventory should close now")
	return
