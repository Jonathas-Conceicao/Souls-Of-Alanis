extends Node2D

signal changed_scene #when load a new scene

func _ready():
	pass

func changeRoom(i_room):
	# if there is any child, remove
	match self.get_child_count():
		1:
			#print("(DB) Removing old scene")
			var oldroom = self.get_child(0)
			self.remove_child(oldroom)
			oldroom.queue_free()
			#print("(DB) Removed")
		0:
			printerr("((WW) Generating first scene")
		_:
			printerr("(EE) CurrentScene node should always have one child! Have %s " % $CurrentScene.get_child_count())
			exit(7)

	# creates new scene and change
	var room_path = i_room.scene
	var room = load(room_path).instance()
	#room.position = Vector2(0,0)
	self.add_child(room)
	#print("(DB) Created")
	print("(DB) Changed to scene: %s (%s)" % [room, room_path])

	emit_signal("changed_scene", room.find_node("EntryPoint").position, i_room.size)
	return
	# sets scene definition
	#get_parent().find_node("CameraLimit").set_limits(5,5)#room.getRoomSize().x, room.getRoomSize().y)
	#get_parent().find_node("Player").find_node("Camera").update_limits()