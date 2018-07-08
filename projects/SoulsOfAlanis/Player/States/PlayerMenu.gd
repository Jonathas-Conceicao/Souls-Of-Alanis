extends 'State.gd'

const Inventory = preload("res://GUI/Inventory.tscn")

var inv
var readyToLeave = false

func enter(host):
	readyToLeave = false
	self.inv = Inventory.instance()
	host.add_child(self.inv)
	self.update_inventory(host)
	self.inv.connect("finished_interaction", self, "_on_Inventory_finished_interaction")
	return

func exit(host):
	self.inv.queue_free()
	return

func update(host, delta):
	if readyToLeave:
		return "Idle"
	return

func update_inventory(host):
	var invViews = host.get_Backpack_views()
	var eqpViews = host.get_Equipament_views()
	self.inv.init(invViews, eqpViews)
	return

func _on_Inventory_finished_interaction(inv, action, index):
	var host = inv.get_parent()
	if action == -1:
		readyToLeave = -1
		return
	if action == 0:
		host.use_from_Backpack(index)
	else:
		host.drop_from_Backpack(index)
	self.update_inventory(host)
	return
