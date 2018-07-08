extends Area2D

const ItemFactory = preload("res://script/tools/RandomItemGenerator.gd")

func _ready():
	randomize()
	return

func _on_takeHit(agressor):
	print("Got hit by:", agressor)
	if agressor.get_name() == "Player":
		var item = ItemFactory.generateAny(1)
		var ib = item.gen_ItemBody()
		self.add_child(ib)
		ib.spawn()
	return