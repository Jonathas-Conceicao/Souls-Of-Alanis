const MIN_HIGH = 2#3
const MAGIC_CONT = 1

enum RoomType {loot = 0, ordinary = 1, connection = 2, mission = 3, challange = 4, final = 5, any = 6}
enum Half { first = 0, second = 1 , any = 2 }

# The scene of this node
var i_scene = null

var parent   = null     # Its entry point
var children = []       # Its exists points
var high       = 0
var any_closed = false  # if it a not fully open scene

# shoud be mannually called only for the level generation
# root, if you will
func _init(gen, i_sc, p, high, n_exit = 1):
  #
  # scene must exists, otherwise, what is my purpose?
  if !i_sc.scene:
    printerr("no scene. \nwhat is my purpose?")
    return null

  self.i_scene  = i_sc
  self.parent = p
  self.high     = high

  printerr("(DB) Generating node high = %s for scene = %s" % [high, i_sc.scene])

  for i in range(0, n_exit):
    printerr("(DB)    generating child %s/%s on high %s" % [i+1, n_exit, high])
    if (self.high <= MIN_HIGH):
      printerr("(DB)    per min high (%s)" % self.high)
      var i_new_scene = gen.pick(any, first, self.i_scene.room_type)
      self.children.append(get_script().new(gen, i_new_scene, self, self.high + 1, i_new_scene.n_exit))
    else:
      if (randi() % (self.high - MIN_HIGH) == 0): # 1/1, 1/2, 1/3, ...
        var half = any if (self.i_scene.half == Half.first) else Half.second
        var i_new_scene = gen.pick(any, half, self.i_scene.room_type)
        self.children.append(get_script().new(gen, i_new_scene, self, self.high + 1, i_new_scene.n_exit))
      else:
        print("(DB) Closed room")
        self.any_closed = true
        self.children = [] # closed scene
