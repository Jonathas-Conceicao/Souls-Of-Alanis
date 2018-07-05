var scene = null

var parent   = null
var children = []

# shoud be mannually called only for the level generation
# root, if you will
func _init(gen, sc_path = "res://scene/Prelude.tscn", p = null, n_exit = 1):
  self.parent = p
  # scene must exists, otherwise, what is my purpose?
  if(!sc_path) || !file_exits(sc_path):
    printerr("no scene. \nwhat is my purpose?")
    return null
  self.scene = sc_path.instance()
  
  # for each exit, find a next scene
  for i in range(0, n_exit):
    #    var new_scene = gen.pick()
    #    var n_exits   = 1
    #    if self.scene.has_method("getNumExits()"):
    #      exits = 
    #    self.children.append(TreeMap.instance(), self, self.scene.)
    pass
