extends Node2D

const InfoRoom  = preload("res://script/map/InfoRoom.gd")

export (String)  var InitialRoom     = "res://scene/Prelude.tscn"
export (Vector2) var InitialRoomSize =  Vector2(2,4)

func _ready():
	randomize()
	$Player.connect("scene_exit", $Map, "walk")
	$Map.connect("moved", $CurrentScene, "changeRoom")
	#$CurrentScene.connect("changed_scene", $Player, "_entryOnRoom")
	$CurrentScene.connect("changed_scene", self, "_adjust_view")

	var start = InfoRoom.new(self.InitialRoom, null, null, 1, Vector2(2,4))

	$Map.add_to_head(start)
	$Map.start()

	pass

#  $CameraLimit.set_limits(x, y)
#  $Player/Camera.update_limits()
func _adjust_view(pos, sz):
	var player = $Player
	#self.remove_child(player)
	var camera = $CameraLimit
	#self.remove_child(camera)

	player.position = pos
	camera.set_limits(sz.x, sz.y)

	#self.add_child(player)
	#self.add_child(camera)
	$Player/Camera.update_limits()
	return


