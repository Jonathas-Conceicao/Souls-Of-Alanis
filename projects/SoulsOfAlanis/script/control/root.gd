extends Node2D

const InfoRoom  = preload("res://script/map/InfoRoom.gd")

export (bool) var debug_mode = true

func _init():
	#randomize() #UNCOMMENT TO RAND IT ALL
	return

func _ready():
	randomize()
	debug.printMsg("Initizaling", debug.msg_type.nrm, self.debug_mode)
	$Player.connect("SceneExit", $Map, "walk")
	$Map.connect("moved", $CurrentScene, "changeRoom")
	$CurrentScene.connect("changed_scene", self, "_adjust_view")

	#var start = InfoRoom.new(self.InitialRoom, null, null, 1, Vector2(2,4.2))
	#$Map.add_to_head(start)
	$Map.start(2)

	return

# Used to adjust camera and its stuff
# pos - the position to place the player
# sz - the current room size, so it can adjust camera limits
func _adjust_view(pos, sz):
	var player = $Player
	var camera = $CameraLimit

	player._state_change("Idle")

	player.position = pos
	camera.set_limits(sz.x, sz.y)

	$Player/Camera.update_limits()
	return
