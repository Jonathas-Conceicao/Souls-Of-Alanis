extends Node2D

signal changed_scene #when load a new scene

export (bool) var debug_mode = true

func _ready():
	debug.printMsg("Current Scene started", debug.msg_type.nrm, self.debug_mode)
	return

# Changes the current rom
# i_room - the info room to change to
func changeRoom(i_room, listOpenChest, listStartedQuests, listFinishedQuests, blocked_entry = false, to_parent = false):
	#TODO: adjust room chest/special items and NPCs according with the list
	# if there is any child, remove
	match self.get_child_count():
		1:
			#print("(DB) Removing old scene")
			var oldroom = self.get_child(0)
			self.remove_child(oldroom)
			oldroom.queue_free()
		0:
			debug.printMsg("Generating first scene", debug.wrn, self.debug_mode)

	# creates new scene and change
	var room_path = i_room.scene
	var room = load(room_path).instance()
	room.set_global_position(Vector2(0, 0))
	if blocked_entry:
		room.get_node("EntryPoint").blocked = true

	## workaround :p
	var listNPC = null
	if room.has_method("listNPC"):
		listNPC = room.listNPC()
	else:
		debug.printMsg("Every room should have a listNPC method!", debug.msg_type.err)
	pass
	if listNPC != null:
		debug.printMsg("Scene %s has method listNPC" % i_room.scene, debug.msg_type.nrm)
		for sc_npc in listNPC:
			if !sc_npc.has_method("get_uniqueID"):
				debug.printMsg("Every NPC should have a get_uniqueID method", debug.msg_type.err, self.debug_mode)
				return null
			pass
			if !sc_npc.has_method("set_enabled"):
				debug.printMsg("Every NPC should have a set_enabled method", debug.msg_type.err, self.debug_mode)
				return null
			pass

			var found = false
			for pl_npc in listStartedQuests:
				if pl_npc.get_uniqueID() == sc_npc.get_uniqueID():
					found = true
					sc_npc.set_enabled(false)
			if !found:
				sc_npc.set_enabled(true)
		pass
	else:
		debug.printMsg("Every room should have a listNPC, even an empty one!", debug.msg_type.err)
	pass

	var listChest = null
	if room.has_method("listChests"):
		listChest = room.listChests()
	else:
		debug.printMsg("Every room should have a listChests method!", debug.msg_type.err)
	pass
	if listChest != null:
		debug.printMsg("Scene %s has method listChests" % i_room.scene, debug.msg_type.nrm)
		
		for i in listChest:
			if !i.has_method("get_uniqueID"):
				debug.printMsg("Every chest/breakable stuff should have a get_uniqueID method", debug.msg_type.err)
				return null
			pass
			if !i.has_method("set_enabled"):
				debug.printMsg("Every chest/breakable should have a set_enabled method", debug.msg_type.err)
				return null
			pass

			var found = false
			for oc in listOpenChest:
				if oc.get_uniqueID() == i.get_uniqueID():
					found = true
					i.set_enabled(false)
					continue
			pass
			if !found:
				i.set_enabled(true)

		pass
	else:
		debug.printMsg("Every room should have a listChests, even an empty one!", debug.msg_type.err)
	pass

	self.add_child(room)
	debug.printMsg("Changed to scene: %s (%s) - %s" % [room, room_path, i_room.size], debug.dbg, self.debug_mode)

	var ep
	if to_parent:
		ep = room.find_node("Exit")
	else:
		ep = room.find_node("EntryPoint")
	ep = Vector2(ep.position.x, ep.position.y)
	self.emit_signal("changed_scene", ep, i_room.size)
	return
