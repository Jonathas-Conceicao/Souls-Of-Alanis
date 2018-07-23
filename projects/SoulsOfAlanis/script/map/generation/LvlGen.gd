const TreeMap   = preload("res://script/map/generation/TreeMap.gd")
const InfoRoom  = preload("res://script/map/InfoRoom.gd")

var i_Prelude = InfoRoom.new("res://scene/Prelude.tscn")

const MAX_TRY   = 5
const N_ROOM    = 15

var i_rooms 	= Array() # InfoRoom array, with repetition
var count 		= 0
var boss_room 	= null
var boss_parent = null
var has_boss 	= false

# Receives the list of scenes for that level
# func init_rooms(rooms_path = []):
# PUBLIC
func _init(rooms_path = [], boss_room = null):
	var f = File.new()
	var has_conn_room = false
	# validation
	for c_room in rooms_path:
		if !(f.file_exists(c_room)):
			debug.printMsg("" + c_room + " does not exists.", debug.msg_type.err)
			return null

		# fill up the deck
		# NOTE: possible bug, it looks like (from debug) that the reference to
		# room path is the same on every added InfoRoom
		# 1) it may not be a problem,
		#  since is just a reference to the same string path
		var i_room = InfoRoom.new(c_room)
		for i in range(0, i_room.mx_rep):
			has_conn_room = has_conn_room || (i_room.room_type == debug.RoomType.connection)
			self.i_rooms.append(i_room)

	pass

	if !has_conn_room:
		debug.printMsg(" It is probably necessary that the system have at least one connection room", debug.msg_type.wrn)

	if !boss_room:
		debug.printMsg(" Boss room not defined, this is probably a mistake", debug.msg_type.err)
		debug.printMsg("Using default", debug.msg_type.wrn)
		self.boss_room = TreeMap.new(null, self.i_Prelude, null, 0, 1, false)
	else:
		#debug.printMsg(" Boss room instanciation not implemented yet", debug.msg_type.err)
		self.boss_room = TreeMap.new(null,InfoRoom.new(boss_room), null, 0, 1, false)
	return

# Randomly choosen a scene
# type - the room type, being the ones defined above
# half - for what part of the level that scene must belong (confuse? talk to Bretana)
# avoid - room type to avoid picking
# n_try - if the codes tries too much, the it forces a scene to be choosen
# return - InfoRoom
# PROTECTED
func pick(type = debug.RoomType.any, half = debug.Half.any, avoid = debug.RoomType.final, n_try = MAX_TRY, force = false):
	if type == avoid:
		debug.printMsg(" Cannot select and avoid the same type", debug.msg_type.wrn)
		debug.printMsg(" Avoiding boss room", debug.msg_type.wrn)
		avoid = debug.RoomType.final
	pass

	self.count += 1
	while (n_try != 0):
		var i_room = self.i_rooms[randi() % i_rooms.size()]
		n_try -= 1

		if force || ( ( (type == debug.RoomType.any) || (i_room.room_type == type) ) && ( i_room.room_type != avoid ) && ( (half == debug.Half.any) || (i_room.half == half) ) ):
			if i_room.room_type != debug.RoomType.connection && self.i_rooms.size() > 1:
				self.i_rooms.erase(i_room)
			return i_room
	pass

	debug.printMsg(" Could not find the right, requesting a connection one, and forcing", debug.msg_type.wrn)
	return self.pick(debug.RoomType.connection, debug.Half.any, debug.RoomType.final, MAX_TRY, true)

# Creates the map
# path_room - the room to start the sub-tree
# generate - wheter or not the should be pick randomlly
# size - if the scene is passed, you probably need to pass its size as well
# PUBLIC
func createTree(generate = true, path_room = null, size = null):
	var f = File.new()

	var head = null
	if generate:
		var r = self.pick()
		head = TreeMap.new(self, r, null, 0, r.n_exit, true)
	else:
		if (!f.file_exists(path_room)) || (!load(path_room).can_instance() || !size):
			debug.printMsg(" Invalid default initial room info", debug.msg_type.err)
			return null
		debug.printMsg(" How did you determinated the room size?", debug.msg_type.wrn)
		head = TreeMap.new(self, InfoRoom.new(path_room, debug.RoomType.ordinary, debug.Half.first, 1, size), null)
	pass
	if !self.has_boss:
		debug.printMsg("Boss room added staticly", debug.msg_type.wrn)
		if !self.boss_parent:
			debug.printMsg("Invalid boss parent, cannot add boss room!", debug.msg_type.err)
			return null
		pass
		self.boss_parent.children.append(self.bossRoom())
		self.has_boss = true
	pass

	return head

func bossRoom():
	return self.boss_room