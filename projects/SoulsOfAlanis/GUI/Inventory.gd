extends "MenuItem.gd"

const InventoryItem  = preload("InventoryItem.tscn")
const InventoryItemS = preload("InventoryItem.gd")

enum Direction {Left, Right, Up, Down}

const COLUMNS = 5
const LINES   = 3

var selected = [0, 0]
var itemSelected
var itemList

func _input(event):
	if   event.is_action_pressed("ui_right"):
		self.selector_move(Right)
	elif event.is_action_pressed("ui_left"):
		self.selector_move(Left)
	elif event.is_action_pressed("ui_up"):
		self.selector_move(Up)
	elif event.is_action_pressed("ui_down"):
		self.selector_move(Down)
	return

func test_ready():
	var i1 = InventoryItem.instance()
	var i2 = InventoryItem.instance()
	var i3 = InventoryItem.instance()
	var i4 = InventoryItem.instance()
	var i5 = InventoryItem.instance()
	var i6 = InventoryItem.instance()

	i1.init(InventoryItemS.Type.Sword , "A basic sword" , 0, null)
	i2.init(InventoryItemS.Type.Armor , "A basic aromor", 0, null)
	i3.init(InventoryItemS.Type.Ring  , "A red ring"    , 0, null)
	i4.init(InventoryItemS.Type.Usable, "A HP Potion"   , 0, null)
	i5.init(InventoryItemS.Type.Ring  , "A green ring"  , 0, null)
	i6.init(InventoryItemS.Type.Ring  , "A blue ring"   , 0, null)

	var exItemList = [i1, i2, i3, i4, i5, i6]
	self.init(exItemList)
	return

func _ready():
	self.test_ready()
	return

func init(itemList):
	self.itemList = itemList
	self.display_items()
	self.update_selected()
	self.update_description()
	return

func selector_move(direction):
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
	set_item_pos($Background/Selector, selected[0], selected[1])
	self.update_selected()
	self.update_description()
	return

func update_selected():
	var index = selected[1] + (selected[0] * COLUMNS)
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

const CELL_SIZE  = 16 * 3
const CELL_SPACE = 1  * 3

func set_item_pos(obj, i, j):
	var basePosition = $Background/InitialPosition.get_position()
	basePosition.x += (j * (CELL_SIZE + CELL_SPACE))
	basePosition.y += (i * (CELL_SIZE + CELL_SPACE))
	obj.set_position(basePosition)
	return
