extends "res://script/Classes/Unique.gd"

const ItemFactory = preload("res://script/tools/RandomItemGenerator.gd")

func _on_takeHit(agressor):
	debug.printMsg("Got hit by:" + agressor)
	if agressor.get_name() == "Player":
		var item = ItemFactory.generateAny(1)
		var ib = item.gen_ItemBody()
		self.add_child(ib)
		ib.spawn()
	return


# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	return global_ids.brealable_wall
