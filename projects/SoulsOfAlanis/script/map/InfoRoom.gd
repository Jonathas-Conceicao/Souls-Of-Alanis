#
var scene     = null  # path scene
var room_type = null  # scene type
var half      = null  # scene position
var n_exit	  = 1	# number of exits of the scene
var size      = null
##

# Creates a RoomShell
# sc - scene path
# rt - room type
# ha - room half
# nw - number of exists on this room
# sz - room size
func _init(sc, rt = null, ha = null, ne = 1, sz = null):
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
