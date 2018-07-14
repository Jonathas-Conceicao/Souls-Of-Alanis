extends Node2D

signal changed_scene #when load a new scene

export (bool) var debug_mode = true

func _ready():
	debug.printMsg("Current Scene started")
	return

# Changes the current rom
# i_room - the info room to change to
func changeRoom(i_room, listOpenChest, listStartedQuests, listFinishedQuests):
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
	
	if room.has_method("listNPC"):
		for i in room.listNPC:
			if !i.has_method("get_uniqueID"):
				debug.printMsg("Every NPC should have a get_uniqueID method", debug.msg_type.err)
				exit(100)
			pass
			if !i.has_method("enabled"):
				debug.printMsg("Every NPC should have a enabled method", debug.msg_type.err)
				exit(101)
			pass

			if listOpenChest.find(i.get_uniqueID) != -1:
				# DISABLE IT
				i.enabled(false)
			else:
				# ENABLED
				i.enabled(true)
			pass
		pass
	else:
		debug.printMsg("Every room should have a listNPc method!", debug.msg_type.err)
	pass

	if room.has_method("listChests"):
		for i in room.listNPC:
			if !i.has_method("get_uniqueID"):
				debug.printMsg("Every chest/breakable stuff should have a get_uniqueID method", debug.msg_type.err)
				exit(10)
			pass
			if !i.has_method("enabled"):
				debug.printMsg("Every chest/breakable should have a enabled method", debug.msg_type.err)
				exit(11)
			pass

			if listOpenChest.find(i.get_uniqueID) != -1:
				# DISABLE IT
				i.enabled(false)
			else:
				# ENABLED
				i.enabled(true)
			pass
		pass
	else:
		debug.printMsg("Every room should have a listChests method!", debug.msg_type.err)
	pass
		
	self.add_child(room)
	
	debug.printMsg("Changed to scene: %s (%s)" % [room, room_path], debug.dbg, self.debug_mode)

	var ep = room.find_node("EntryPoint")
	self.emit_signal("changed_scene", ep.position, i_room.size)
	return
