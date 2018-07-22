extends 'State.gd'

const Inventory  = preload("res://GUI/Inventory.tscn")
const PlayerInfo = preload("res://GUI/PlayerInfo.tscn")

var inv
var info
var readyToLeave = false

func enter(host):
	host.set_animation("Idle")
	readyToLeave = false
	self.inv = Inventory.instance()
	self.info = PlayerInfo.instance()
	host.add_child(self.inv)
	host.add_child(self.info)
	self.update_all(host)
	self.inv.connect("finished_interaction", self, "_on_Inventory_finished_interaction")
	host.connect("DataUpdated", self, "update_all")
	# No need for info signal if focused == false
	# self.info.connect("finished_interaction", self, "_on_Inventory_finished_interaction")
	return

func exit(host):
	self.inv.queue_free()
	self.info.queue_free()
	host.disconnect("DataUpdated", self, "update_all")
	return

func update(host, delta):
	if readyToLeave:
		return "Idle"
	return

func update_all(host):
	self.update_inventory(host)
	self.update_info(host)
	return

func update_inventory(host):
	var invViews = host.get_Backpack_views()
	var eqpViews = host.get_Equipament_views()
	self.inv.init(invViews, eqpViews)
	return

func update_info(host):
	var data = host.get_data_for_display()
	self.info.focused(false)
	self.info.enabled(true)
	self.info.init(data[0], data[1])
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
	return
