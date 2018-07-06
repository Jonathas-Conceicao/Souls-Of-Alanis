extends Button

const TreeMap = preload("res://script/Classes/TreeMap.gd")

const MAX_TRY = 50
const N_ROOM  = 15

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
			printerr("(DB) Inside LvlGen -> getSceneType")
			if (type == connection): has_conn_room = true

		var half = first
		if scene.has_method("getSceneHalf"):
			half = scene.getSceneHalf()

		var mx_rep = 1
		if scene.has_method("getMaxRep"):
			mx_rep = scene.getMaxRep()

		var n_exit = 1
		if scene.has_method("getNumExit"):
			mx_rep = scene.getNumExit()

		# fill up the deck
		for i in range(0, mx_rep):
			self.i_rooms.append(InfoRoom.new(c_room, type, half))

	if !has_conn_room:
		printerr("(WW) It is probably necessary that the system have at least one connection room")
	return

# Creates the map
static func createTree(gen, scene, i_rooms = []):
	printerr("(DB) Creating tree")
	var f = File.new()

	if (!scene):
		printerr("(EE) Invalid scene for root node");
		return null

#	printerr("(DB) The scenes: ")
#	for r in rooms:
#		printerr("(DB) path: %s" % r.scene)
#		printerr("(DB) type: %s" % r.room_type)
#		printerr("(DB) half: %s" % r.half)
#		printerr("(DB) exits %s" % r.n_exit)

	if (!i_rooms):
		printerr("(EE) Invalid scenes for the map");
		return null

	return TreeMap.new(gen, InfoRoom.new(scene, ordinary), null, 0, 1)

# Randomly choosen a scene
# type  : the room type, being the ones defined above
# half  : for what part of the level that scene must belong (confuse? talk to Bretana)
# avoid : room type to avoid picking
# n_try : if the codes tries too much, the it forces a scene to be choosen
# return : InfoRoom
func pick(type = any, half = any, avoid = final, n_try = MAX_TRY):
	if type == RoomType.avoid:
		printerr("(EE) Cannot select and avoid the same type")
		avoid = final
		pass

	while (n_try != 0):
		var i_room = self.i_rooms[randi() % i_rooms.size()]
		n_try -= 1
		if ( (type == any) || (i_room.room_type == type) ) && (i_room.room_type != avoid) && ( (half == any) || (i_room.half == half) ):
			if i_room.room_type != connection && self.i_rooms.size() > 1:
				self.i_rooms.erase(i_room)
			self.count += 1
			return i_room

	self.count += 1
	printerr("(WW) Could not find the right, requesting a connection one")
	return self.pick(connection, -1)

func printTree(node, recursive = false):
	if node.parent == null:
		print("ROOT!")
	print("Scene: %s " % node.scene)
	print("Parent: %s" % node.parent)
	print("Children: (%s) %s" % [ node.children.size(), node.children])
	print("High: %s" % node.high)
	for i in node.children:
		if recursive:
			printTree(i, recursive)
		else:
			print("Info: " % i)

func _on_Button_pressed():
	printerr("(DB) Pressed")
	var s = PoolStringArray(["res://script/Classes/DummyRoom.tscn", "res://script/Classes/DummyRoom.tscn"])
	self.init_rooms(s)
	self.root = createTree(self, load("res://script/Classes/DummyRoom.tscn").instance(), self.i_rooms)
	printTree(self.root, true)
	pass # replace with function body

class InfoRoom:
	#
	var scene     = null  # scene
	var room_type = null  # scene type
	var half      = null  # scene position
	var n_exit		= 1			# number of exits of the scene
	##

	# Creates a RoomShell
	func _init(sc, rt = null, ha = null, ne = 1):
		self.scene      = sc
		self.room_type  = rt
		self.half       = ha
		self.n_exit     = ne
		return
