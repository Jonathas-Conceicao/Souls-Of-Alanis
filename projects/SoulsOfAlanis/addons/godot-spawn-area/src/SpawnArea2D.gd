tool
extends Container


export (Array)	var MobList
export (PackedScene)		var Mob
export (int)     			var TotMobCap 	= 1
export (bool)    			var FlyEnabled 	= false

var MobCap = 0

func _ready():
	randomize()
	
	while self.MobCap < self.TotMobCap:
		place_mob(pick_rand())

	return

func pick_rand():
	var path = self.MobList[randi() % self.MobList.size()]
#	return self.Mob
	return load(path)

#func _enter_tree():
#    connect("", self, "clicked")

func place_mob(mobClass):
	if (mobClass == null) || (!mobClass.can_instance()):
		return
	if self.MobCap > self.TotMobCap:
		return
	self.MobCap += 1

	var mob = mobClass.instance()
	add_child(mob)
## error protection for design time
	var treeroot = get_tree().get_root()
	if treeroot:
		var rootnode = treeroot.get_node("root")
		if rootnode:
			var player = rootnode.get_node("Player")
			if 	player:
				mob.connect("StateChanged", player, "_on_creatureStateeChanged")

#	var l_x = rand_range(0 + (mob.get_size().x/2), (rect_size.x) - (mob.get_size().x/2))
#	var l_y = rand_range(0,                        (rect_size.y) - (mob.get_size().y/2))

	var l_x = rand_range(0, rect_size.x)
	var l_y = rand_range(0, rect_size.y)


	# no specification means the mob can fly
	if (self.FlyEnabled && (!mob.has_method("is_ranger") || !mob.is_ranger())):
		mob.set_position(Vector2(l_x, l_y))
	else:
		mob.set_position(Vector2(l_x, rect_size.y))
	pass
