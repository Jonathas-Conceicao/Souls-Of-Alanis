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
  self.scene      = sc
  self.room_type  = rt
  self.half       = ha
  self.n_exit     = ne
  self.size       = sz
  return
