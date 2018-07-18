extends Node2D

const InfoRoom  = preload("res://script/map/InfoRoom.gd")

var i_Ord1 = preload("res://script/map/InfoRoom.gd").new("res://scene/village/VillageHope.tscn", debug.RoomType.ordinary, debug.Half.first, 1, Vector2(3.2, 3.2))

export (bool) var debug_mode = true
export (bool) var rand = false

func _init():
	if rand:
		randomize()
	return

func _ready():
	$Player.visible = false
	$Player/HUD.enabeled(false)
	
	debug.printMsg("Initizaling", debug.msg_type.nrm, self.debug_mode)
	$Player.connect("SceneExit", $Map, "walk")
	$Map.connect("moved", $CurrentScene, "changeRoom")
	$CurrentScene.connect("changed_scene", self, "_adjust_view")

	#var start = InfoRoom.new(self.InitialRoom, null, null, 1, Vector2(2,4.2))

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


func _on_Opening_finished_cinematic(obj):
	$Opening.enabeled(false)
	$Opening.queue_free()

	$Player.visible = true
	$Player/HUD.enabeled(true)
	
	$Map.add_to_head(i_Ord1)
	$Map.start()
	return