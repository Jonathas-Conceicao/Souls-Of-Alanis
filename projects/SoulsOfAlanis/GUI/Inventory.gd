extends "MenuItem.gd"

const InventoryItem  = preload("InventoryItem.tscn")
const InventoryItemS = preload("InventoryItem.gd")

const COLUMS = 5

var itemList = []

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
	return

func display_items():
	var i = 0
	var j = 0
	for item in itemList:
		$Background.add_child_below_node($Background/InitialPosition, item)
		self.set_item_pos(item, i, j)
		i = (i + 1)
		j = int(i /  5)
		i %= COLUMS
	return

const CELL_SIZE  = 16 * 3
const CELL_SPACE = 1  * 3

func set_item_pos(obj, i, j):
	var basePosition = $Background/InitialPosition.get_position()
	basePosition.x += (i * (CELL_SIZE + CELL_SPACE))
	basePosition.y += (j * (CELL_SIZE + CELL_SPACE))
	obj.set_position(basePosition)
	return
