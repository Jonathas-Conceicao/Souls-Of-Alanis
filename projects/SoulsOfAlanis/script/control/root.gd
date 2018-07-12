extends Node2D

const InfoRoom  = preload("res://script/map/InfoRoom.gd")

export (String) var InitialRoom = "res://scene/Prelude.tscn"

func _ready():
	randomize()
	$Player.connect("scene_exit", $Map, "walk")
	$Map.connect("moved", $CurrentScene, "changeRoom")
	#$CurrentScene.connect("changed_scene", $Player, "_entryOnRoom")
	$CurrentScene.connect("changed_scene", self, "_adjust_view")

	var start = InfoRoom.new(self.InitialRoom, null, null, 1, Vector2(2,4.2))

	$Map.add_to_head(start)
	$Map.start()

	pass

func _adjust_view(pos, sz):
	var player = $Player
	var camera = $CameraLimit

	# TODO: solved the problem of player behind scene background
	#self.remove_child(player)
	#self.remove_child(camera)

	player.position = pos
	camera.set_limits(sz.x, sz.y)

	#self.add_child(player)
	#self.add_child(camera)
	$Player/Camera.update_limits()

	return