extends Button

const TreeMap = preload("res://script/Classes/TreeMap.gd")

const MAX_TRY = 5
const N_ROOM  = 15
const DEF_ROOM = "res://script/Classes/DummyRoom.tscn"

enum RoomType {loot, ordinary, connection, mission, challange, final, any, avoid}
enum Half { first, second , any }

var i_rooms = Array() # InfoRoom array, with repetition
var count 	= 0    		# Number of room already picked
var root  	= null

func ready():
  randomize()

# Receives the list of scenes for that level
func init_rooms(rooms_path = []):
  printerr("(DB) Initilizing rooms")
  var f = File.new()
  var has_conn_room = false
  # validation
  for c_room in rooms_path:
    if !f.file_exists(c_room):
      printerr(c_room + " does not exists.")
      exit(1)

    var scene = load(c_room).instance()

    var type = first
    if scene.has_method("getSceneType"):
      type = scene.getSceneType()
      if (type == connection): has_conn_room = true
    else:
      printerr("(WW) Couldn't getSceneType, using default")

    var half = first
    if scene.has_method("getSceneHalf"):
      half = scene.getSceneHalf()
    else:
      printerr("(WW) Couldn't getSceneHalf, using default")

    var mx_rep = 1
    if scene.has_method("getMaxRep"):
      mx_rep = scene.getMaxRep()
    else:
      printerr("(WW) Couldn't getMaxRep, using default")

    var n_exit = 1
    if scene.has_method("getNumExit"):
      n_exit = scene.getNumExit()
    else:
      printerr("(WW) Couldn't getNumExit, using default")

    # fill up the deck
    # NOTE: possible bug, it looks like (from debug) that the reference to 
    # room path is the same on every added InfoRoom
    # 1) it may not be a problem, 
    #  since is just a reference to the same string path
    for i in range(0, mx_rep):
      self.i_rooms.append(InfoRoom.new(c_room, type, half, n_exit))

    pass

  if !has_conn_room:
    printerr("(WW) It is probably necessary that the system have at least one connection room")
  return

# Creates the map
static func createTree(gen, path_room = DEF_ROOM, i_rooms = []):
  var f = File.new()

  if (!f.file_exists(path_room)) || (!load(path_room).can_instance()):
    printerr("(EE) Invalid default initial room")
    return null

#  printerr("(DB) The scenes: ")
#  for r in rooms:
#    printerr("(DB) path: %s" % r.scene);
#    printerr("(DB) type: %s" % r.room_type)
#    printerr("(DB) half: %s" % r.half)
#    printerr("(DB) exits %s" % r.n_exit)

  return TreeMap.new(gen, InfoRoom.new(path_room, ordinary), null, 0, 1)

# Randomly choosen a scene
# type  : the room type, being the ones defined above
# half  : for what part of the level that scene must belong (confuse? talk to Bretana)
# avoid : room type to avoid picking
# n_try : if the codes tries too much, the it forces a scene to be choosen
# return : InfoRoom
func pick(type = any, half = any, avoid = final, n_try = MAX_TRY, force = false):
  if type == avoid:
    printerr("(EE) Cannot select and avoid the same type")
    avoid = final
  pass

  self.count += 1
  while (n_try != 0):
    var i_room = self.i_rooms[randi() % i_rooms.size()]
    n_try -= 1
    if force || ( ( (type == any) || (i_room.room_type == type) ) && ( i_room.room_type != avoid ) && ( (half == any) || (i_room.half == half) ) ):
      if i_room.room_type != connection && self.i_rooms.size() > 1:
        self.i_rooms.erase(i_room)
      return i_room
  pass

  printerr("(WW) Could not find the right, requesting a connection one, and forcing")
  return self.pick(connection, any, final, MAX_TRY, true)

func printTree(node, recursive = false):
  print("------------------------")
  if node.parent == null:
    print("ROOT!")
  print("Scene: %s " % node.i_scene)
  print(">>Scene: %s - (t: %s, h: %s) e: %s" % [node.i_scene.scene, node.i_scene.room_type, node.i_scene.half, node.i_scene.n_exit])
  print("Parent: %s" % node.parent)
  if node.parent != null:
    print(">>Parent: %s - (t: %s, h: %s) e: %s" % [node.parent.i_scene.scene, node.parent.i_scene.room_type, node.parent.i_scene.half, node.parent.i_scene.n_exit])
  print("High: %s" % node.high)
  print("Children: (%s) %s" % [ node.children.size(), node.children])
  print("|---------------|")
  for i in node.children:
    if recursive:
      printTree(i, recursive)
    else:
      print("Info: " % i)
  print("|---------------|")
  print("------------------------")


func _on_Button_pressed():
  printerr("(DB) Pressed")
  var s = PoolStringArray(["res://script/Classes/DummyRoom.tscn", "res://script/Classes/DummyRoom.tscn"])
  self.init_rooms(s)
  self.root = createTree(self, "res://script/Classes/DummyRoom.tscn", self.i_rooms)
  printTree(self.root, true)
  printerr("(DB) Succefully generated a #%s rooms map" % self.count)
  pass # replace with function body

class InfoRoom:
  #
  var scene     = null  # path scene
  var room_type = null  # scene type
  var half      = null  # scene position
  var n_exit	= 1	# number of exits of the scene
  ##

  # Creates a RoomShell
  func _init(sc, rt = null, ha = null, ne = 1):
    self.scene      = sc
    self.room_type  = rt
    self.half       = ha
    self.n_exit     = ne
    return
