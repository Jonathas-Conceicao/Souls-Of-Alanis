extends Node2D

export (bool) var debug_mode = true

const LvlGen = preload("res://script/map/generation/LvlGen.gd")
const TreeMap = preload("res://script/map/generation/TreeMap.gd")

export (String) onready var P_BoosRoomForest = 	"res://scene/castle/connection/forest/connection/fconnection_1.tscn"
export (PoolStringArray) onready var P_ForestRooms = [
"res://scene/forest/challenge/fchallenge_1.tscn",
"res://scene/forest/challenge/fchallenge_2.tscn",
"res://scene/forest/connection/fconnection_1.tscn",
"res://scene/forest/corridor/fcorridor_1.tscn",
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

# PUBLIC
func _ready():
	randomize() #UNCOMMENT TO RAND MAP
	var gen = null
	## FOREST
	gen = LvlGen.new(self.P_ForestRooms)
	self.ForestTree = gen.createTree()
	# TODO: 
	## generate Forest boss room
	## add it to the tree (some random final node)
	## interlink with next tree

	## CASTLE
	gen = LvlGen.new(P_CastleRooms)
	self.CastleTree = gen.createTree()
	# TODO:
	## generate Castle boss room
	## add it to the tree (some random final node)
	## interlink with next tree

	## CRIPT
	gen = LvlGen.new(P_CriptRooms)
	self.CriptTree = gen.createTree()
	# TODO:
	## generate Castle boss room
	## add it to the tree (some random final node)
	## interlink with next tree

	#self.current_tree = self.ForestTree
	return

# TODO: connect trees
# player - pretty self explanatory
# to - indicates direction onto the tree
#  -1: go back to parent
#   0:  children at most left
#   N: children at most right
# SIGNAL connection <- player SceneExit
func walk(player = null, to = 0):
	if to == -1:
		if !self.current_node.parent:
			debug.printMsg(" Cannot go back to null parent (this is expected on Prelude only!", debug.msg_type.wrn, self.debug_mode)
			return
		self.current_node = self.current_node.parent
	elif !self.current_node.children.empty():
		self.current_node = self.current_node.children[to]
	else:
		debug.printMsg(" Closed doors are not implemented yet", debug.msg_type.wrn, self.debug_mode)
		debug.printMsg(" Should not be entering closed doors!", debug.msg_type.err, self.debug_mode)
		return

	emit_signal("moved", self.current_node.i_scene, player.Chests, player.StartedQuests, player.FinishedQuests)
	return

# start the map on a given tree
# id_tree indictes the tree to start
# PUBLIC
func start(id_tree = 0):
	match id_tree:
		1:
			self.current_node = self.ForestTree
		2:
			self.current_node = self.CastleTree
		3:
			self.current_node = self.CriptTree
		0:
			debug.printMsg(" Main scene should have been added mannually", debug.msg_type.wrn, self.debug_mode)
		_:
			debug.printMsg(" Invalid tree start", debug.msg_type.err, self.debug_mode)
			exit(10)

	emit_signal("moved", self.current_node.i_scene, [], [], [])
	return

# add a given room to the head to the main tree
# i_room - the info room of the new head
# PUBLIC <- be carefull
func add_to_head(i_room):
	if !i_room:
		debug.printMsg(" Cannot add a invalid room", debug.msg_type.err, self.debug_mode)
		exit(9)

	var node = TreeMap.new(null, i_room, null, -1, 1, false)
	var cur = self.current_tree

	self.current_tree.parent = node
	node.children.insert(0, cur)
	self.current_tree = node
	self.current_node = node

	return
