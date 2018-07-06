const MIN_HIGH = 3
const MAGIC_CONT = 1

enum RoomType {loot = 0, ordinary = 1, connection = 2, mission = 3, challange = 4, final = 5, any = 6}
enum Half { first = 0, second = 1 , any = 2 }

# The scene of this node
var i_scene = null

var i_parent   = null   # Its entry point
var i_children = []     # Its exists points
var high	     = 0

# shoud be mannually called only for the level generation
# root, if you will
func _init(gen, i_sc, p, high, n_exit = 1):
	# scene must exists, otherwise, what is my purpose?
	if !i_sc.scene:
		printerr("no scene. \nwhat is my purpose?")
		return null

	self.i_scene 	= i_sc
	self.i_parent = p
	self.high 		= high

	for i in range(0, n_exit):
		if (self.high <= MIN_HIGH):
			var avoid_type = self.i_scene.room_type
			var i_new_scene
			i_new_scene = gen.pick(any, any, avoid_type)
			self.i_children.append(get_script().new(gen, i_new_scene, self, self.high + 1, 1))
		else:
			if (randi() % (MAGIC_CONT * (high - MIN_HIGH)) == 0):
				var half = any if (self.half == first) else second
				var i_new_scene = gen.pick(any, half, self.i_scene.room_type)
				self.i_children.append(new(gen, i_new_scene, self, self.high + 1, 1))

		pass