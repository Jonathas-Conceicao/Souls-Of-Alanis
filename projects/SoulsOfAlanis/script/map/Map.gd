extends Node2D

const LvlGen = preload("res://script/map/generation/LvlGen.gd")
const TreeMap = preload("res://script/map/generation/TreeMap.gd")

export (String) onready var P_BoosRoomForest = 	"res://scene/castle/connection/forest/connection/fconnection_1.tscn"
export (PoolStringArray) onready var P_ForestRooms = [
"res://scene/forest/challenge/fchallenge_1.tscn",
"res://scene/forest/challenge/fchallenge_2.tscn",
"res://scene/forest/connection/fconnection_1.tscn",
"res://scene/forest/corridor/fcorridor_1.tscn",
"res://scene/forest/objects/fchest.tscn",
"res://scene/forest/ordinary/fordinary_1.tscn",
"res://scene/forest/ordinary/fordinary_2.tscn",
"res://scene/forest/ordinary/fordinary_3.tscn",
"res://scene/forest/quest/fquest_1.tscn",
"res://scene/forest/spoils/fspoils_1.tscn",
"res://scene/forest/spoils/fspoils_2.tscn"
]

export (String) onready var P_BoosRoomCastle = "res://scene/castle/connection/Connection1.tscn"
export (PoolStringArray) onready var P_CastleRooms = [
"res://scene/castle/challenge/Challenge1.tscn",
"res://scene/castle/challenge/Challenge2.tscn",
"res://scene/castle/connection/Connection1.tscn",
"res://scene/castle/lute/Lute1.tscn",
"res://scene/castle/ordinary/Ord1.tscn",
"res://scene/castle/ordinary/Ord2.tscn"
]

export (String) onready var P_BoosRoomCript = 	"res://scene/castle/connection/crypt/connection/Cconnection_1.tscn"
export (PoolStringArray) onready var P_CriptRooms= [
"res://scene/crypt/challenge/Cchallenge_1.tscn",
"res://scene/crypt/connection/Cconnection_1.tscn",
"res://scene/crypt/connection/Cconnection_2.tscn",
"res://scene/crypt/connection/Cconnection_3.tscn",
"res://scene/crypt/corridor/Ccorridor_1.tscn",
"res://scene/crypt/ordinary/Cordinary_1.tscn",
"res://scene/crypt/quest/Cquest_1.tscn",
"res://scene/crypt/spoils/Cspoils_1.tscn"
]


onready var ForestTree = null #TreeMap
onready var CastleTree = null #TreeMap
onready var CriptTree  = null #TreeMap

onready var current_tree = null #TreeMap

onready var current_node = null #TreeMap

signal moved(idx) #Indicates player moved on map

func _ready():
	var gen = null
	## FOREST
	gen = LvlGen.new(self.P_ForestRooms)
	self.ForestTree = gen.createTree(null, true)
	# TODO: randomly chose one
	## this.one.child[closed].child = boss_room

	## CASTLE
	gen = LvlGen.new(P_CastleRooms)
	self.CastleTree = gen.createTree(null, true)

	# TODO: randomly chose one
	## this.one.child[closed].child = boss_room

	## CRIPT
	gen = LvlGen.new(P_CriptRooms)
	self.CriptTree = gen.createTree(null, true)
	# TODO: randomly chose one
	## this.one.child[closed].child = boss_room

	self.current_tree = self.CriptTree

	pass

# TODO: connect trees
# to - indicates direction onto the tree
# -1 - go back to parent
# 0 - children at most left
# N - children at most right
func walk(player = null, to = 0):
	if to == -1:
		if !self.current_node.parent:
			printerr("(WW) Cannot go back to null parent (this is expected on Prelude only!")
			return
		self.current_node = self.current_node.parent
	elif !self.current_node.children.empty():
		self.current_node = self.current_node.children[to]
	else:
		printerr("(WW) Closed doors are not implemented yet")
		printerr("(EE) Should not be entering closed doors!")
		return

	emit_signal("moved", self.current_node.i_scene)
	return

func start(id_tree = 0):
	match id_tree:
		1:
			self.current_node = self.ForestTree
		2:
			self.current_node = self.CastleTree
		3:
			self.current_node = self.CriptTree
		_:
			printerr("(WW) Main scene should have been added mannually")

	emit_signal("moved", self.current_node.i_scene)

func add_to_head(i_room):
	if !i_room:
		printerr("(EE) Cannot add a invalid room")
		exit(9)

#(gen, i_sc, p, high = 0, n_exit = 1, create_child = true):
	var node = TreeMap.new(null, i_room, null, -1, 1, false)
	var cur = self.current_tree

	self.current_tree.parent = node
	node.children.insert(0, cur)
	self.current_tree = node
	self.current_node = node

	return






