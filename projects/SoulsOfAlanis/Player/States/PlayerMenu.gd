extends 'State.gd'

const Inventory = preload("res://GUI/Inventory.tscn")

var inv
var readyToLeave = false

func enter(host):
	readyToLeave = false
	self.inv = Inventory.instance()
	var invViews = host.get_Backpack_views()
	var eqpViews = host.get_Equipament_views()
	self.inv.init(invViews, eqpViews)
	self.inv.connect("finished_interaction", self, "_on_Inventory_finished_interaction")
	host.add_child(self.inv)
	return

func exit(host):
	self.inv.queue_free()
	return

func update(host, delta):
	if readyToLeave:
		return "Idle"
	return

func _on_Inventory_finished_interaction(inv, action, index):
	if action == -1:
		readyToLeave = -1
		return
	return # TODO: @Jonathas make item drop and item swap
