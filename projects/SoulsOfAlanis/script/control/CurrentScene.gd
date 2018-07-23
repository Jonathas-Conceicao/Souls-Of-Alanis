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

	self.add_child(room)
	debug.printMsg("Changed to scene: %s (%s) - %s" % [room, room_path, i_room.size], debug.dbg, self.debug_mode)

 	## workaround :p
	var listNPC = null
	if room.has_method("listNPC"):
		listNPC = room.listNPC()
	else:
		debug.printMsg("Every room should have a listNPC method!", debug.msg_type.err)
	pass
	if listNPC != null:
		debug.printMsg("Scene %s has method listNPC" % i_room.scene, debug.msg_type.nrm)
		for i in room.listNPC():
			if !i.has_method("get_uniqueID"):
				debug.printMsg("Every NPC should have a get_uniqueID method", debug.msg_type.err, self.debug_mode)
				return null
			pass
			if !i.has_method("set_enabled"):
				debug.printMsg("Every NPC should have a set_enabled method", debug.msg_type.err, self.debug_mode)
				return null
			pass

			for j in listStartedQuests:
				#if i.get_uniqueID() == j:
				if listStartedQuests.find(i.get_uniqueID()) != -1:
					# DISABLE IT
					i.enabled(false)
			pass
		pass
	else:
		debug.printMsg("Every room should have a listNPC, even an empty one!", debug.msg_type.err)
	pass

	var listChest = null
	if room.has_method("listChsests"):
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

			if listOpenChest.find(i.get_uniqueID) != -1:
				# DISABLE IT
				i.set_enabled(false)
			else:
				# ENABLED
				i.set_enabled(true)
			pass
		pass
	else:
		debug.printMsg("Every room should have a listChests, even an empty one!", debug.msg_type.err)
	pass

	var ep
	if to_parent:
		ep = room.find_node("Exit")
	else:
		ep = room.find_node("EntryPoint")
	ep = Vector2(ep.position.x, ep.position.y)
	self.emit_signal("changed_scene", ep, i_room.size)
	return
