enum RoomType {loot, ordinary, connection, mission, challange, final, any}
enum Half { first, second, any }

const MAX_TRY = 5

var rooms = []    # InfoRoom array

func ready():
  randomize()

# Receives the list of scenes for that level
func _init(rooms_path = []):

  # validation
  for c_room in rooms_path:
    if !file_exists(c_room):
      printerr(c_room + " does not exists.")
      exit(1)

    var scene = load(c_room)
    if scene.has_method
    var type = null

#  func _init(sc, rt = null, h = null, mr = 0):
    self.rooms.append(InfoRoom.init(scene), )
    return

# Randomly choosen a scene
# type  : the room type, being the ones defined above
# half  : for what part of the level that scene must belong (confuse? talk to Bretana)
# n_try : if the codes tries too much, the it forces a scene to be choosen
func pick(type = any, half = any, n_try = MAX_TRY):
  #  room = rooms[randi() % rooms.size()]
  #  for i in range(0, n_try):
  #    if ( (type == any) || (room.type == type) ) && ( (half == any) || (room.halt == half) ):
  #      if room.mark():
  #        return room
  #
  #  room.mark(yes)
  return room


class InfoRoom:
  #
  var scene     = null  # loaded scene
  var room_type = null  # scene type
  var half      = null  # scene position
  var max_rep   = 0     # max num repetions of that scene on the level
  ##
  #
  var cur_rep   = 0
  var usable    = true

  # NOTE: max_rep = 0 <=> infite (e.g. for connections rooms)
  func _init(sc, rt = null, h = null, mr = 0):
    self.scene     = sc
    self.room_type = rt
    self.half      = h
    self.max_rep   = mr
    self.cur_rep   = 0
    return self

  func mark(force = false):
    if force || self.usable:
      self.cur_rep += 1
      if self.max_rep == self.cur_rep:
        self.usable = false
      return self.scene
    else:
      printerr("(WW) Cannot mark, too many uses!")
      return null






