extends Node2D
#
#const InfoRoom  = preload("res://script/map/InfoRoom.gd")
const LvlGen = preload("res://script/map/generation/LvlGen.gd")
const TreeMap = preload("res://script/map/generation/TreeMap.gd")

#export (String) onready var P_InitialRoom    = "res://scene/Prelude.tscn"

#export (String) onready var P_BoosRoomGarden = "res://scene/garden/connection/conn1.tscn"
#export (PoolStringArray) onready var P_GardenRooms    = ["res://scene/garden/ordinary/ordinary1.tscn", "res://scene/garden/ordinary/ordinary2.tscn"]

export (String) onready var P_BoosRoomCastle = "res://scene/castle/connection/Connection1.tscn"
export (PoolStringArray) onready var P_CastleRooms    = ["res://scene/castle/ordinary/Ord1.tscn", "res://scene/castle/ordinary/Ord2.tscn"]

#export (String) onready var P_BoosRoomCript  = "res://scene/cript/connection/conn1.tscn"
#export (PoolStringArray) onready var P_CriptRooms     = ["res://scene/cript/ordinary/ordinary1.tscn", "res://scene/cript/ordinary/ordinary2.tscn"]

onready var GardenTree = null #TreeMap
onready var CastleTree = null #TreeMap
onready var CriptTree  = null #TreeMap

onready var current_tree = null #TreeMap

onready var current_node = null #TreeMap

signal moved(idx) #Indicates player moved on map

func _ready():
  var gen = null
  ## GARDEN
  #gen = LvlGen.new(self.P_GardenRooms)
  #self.GardenTree = gen.createTree(P_InitialRoom)
  # TODO: randomly chose one
  ## this.one.child[closed].child = boss_room
  
  ## CASTLE
  gen = LvlGen.new(P_CastleRooms)
  self.CastleTree = gen.createTree(null, true)
  
  # TODO: randomly chose one
  ## this.one.child[closed].child = boss_room

  ## CRIPT
  #gen = LvlGen.new(P_CriptRooms)
  #self.CriptTree = gen.createTree(null, true)
  # TODO: randomly chose one
  ## this.one.child[closed].child = boss_room

  #CHANGE!
  self.current_tree = self.CastleTree
  pass

# TODO: connect trees
# to - indicates direction onto the tree
# -1 - go back to parent
# 0 - children at most left
# N - children at most right
func walk(to = 0):
  if to == -1:
    self.current_node = self.current_node.parent
  elif !self.current_node.children.empty():
    self.current_node = self.current_node.children[to]
  else:
    printerr("(WW) Closed doors are not implemented yet")
    printerr("(EE) Should not be entering closed doors!")
    return
  
  emit_signal("moved", self.current_node.i_scene)
  
func start(id_tree = 0):
  match id_tree:
    1:
      self.current_node = self.GardenTree
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
    
    
  
  
  
  