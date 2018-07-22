#
var scene     = null  # path scene
var room_type = null  # scene type
var half      = null  # scene position
var n_exit	  = 1	# number of exits of the scene
var size      = null
var mx_rep    = 1 # max repetions of this scene
##
const MAX_REP = 10

# Creates a RoomShell
# sc - scene path
# rt - room type
# ha - room half
# nw - number of exists on this room
# sz - room size
func _fill(sc, rt = null, ha = null, ne = 1, sz = null, mr = 1):
  if !sc || sc == null:
    debug.printMsg("Invalid scene for InfoRoom", debug.msg_type.err)
    return null
  pass
  self.scene      = sc
  self.room_type  = rt
  self.half       = ha
  if ne == 0:
    debug.printMsg("Room should always have at least one exit")
    return null
  pass
  self.n_exit     = ne
  self.size       = sz
  return

# Create a RoomShell
# sc_path - path to the scene
func _init(sc_path):
	var scene = load(sc_path).instance()

	var type = debug.RoomType.connection
	if scene.has_method("getSceneType"):
		type = scene.getSceneType()
	else:
		debug.printMsg("Couldn't getSceneType, using default", debug.msg_type.wrn)

	var half = debug.Half.first
	if scene.has_method("getSceneHalf"):
		half = scene.getSceneHalf()
	else:
		debug.printMsg("Couldn't getSceneHalf, using default", debug.msg_type.wrn)

	var mx_rep = MAX_REP
	if scene.has_method("getMaxRep"):
		mx_rep = scene.getMaxRep()
	else:
		debug.printMsg("Couldn't getMaxRep, using default (%s)" % mx_rep, debug.msg_type.wrn)

	var n_exit = 1
	if scene.has_method("getNumExit"):
		n_exit = scene.getNumExit()
	else:
		debug.printMsg(" Couldn't getNumExit, using default", debug.msg_type.wrn)

	var size = Vector2(1,1)
	if scene.has_method("getSize"):
		size = scene.getSize()
	else:
		debug.printMsg(" Couldn't getSize, using default, this is probably a mistake", debug.msg_type.err)
	
	_fill(sc_path, type, half, n_exit, size, mx_rep)
	
	return 