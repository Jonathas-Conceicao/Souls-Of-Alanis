extends Node2D

const InfoRoom  = preload("res://script/map/InfoRoom.gd")

#var i_Ord1 = InfoRoom.new("res://scene/castle/ordinary/Ord1.tscn", debug.RoomType.ordinary, debug.Half.first, 1, Vector2(2, 4))

export (String) var StartScene = "res://scene/village/VillageHope.tscn"
export (PackedScene) var PauseMenu = preload("res://scene/menu/PauseMenu.tscn")

export (bool) var debug_mode = true
export (bool) var rand = false

func _init():
	if rand:
		randomize()
	return

func _ready():
	$Player.visible = false
	$Player/HUD.enabled(false)
	
	debug.printMsg("Initizaling", debug.msg_type.nrm, self.debug_mode)
	$Player.connect("SceneExit", $Map, "walk")
	$Player.connect("PauseMenu", self, "_open_PauseMenu")
	$Player/DIE.connect("ReloadGame", self, "_reload_Game")
	$Map.connect("moved", $CurrentScene, "changeRoom")
	$CurrentScene.connect("changed_scene", self, "_adjust_view")

	#var start = InfoRoom.new(self.InitialRoom, null, null, 1, Vector2(2,4.2))

	return

func _open_PauseMenu(call):
	var pmenu = self.PauseMenu.instance()
	get_tree().set_pause(true)
	pmenu.connect("finished_interation", self, "_close_PauseMenu")
	pmenu.connect("ReloadGame", self, "_reload_Game")
	add_child(pmenu)
	return

func _close_PauseMenu(menu):
	get_tree().set_pause(false)
	menu.queue_free()
	return

func _reload_Game(call, free_call = false):
	if free_call:
		call.queue_free()
	$Player.clean()
	$Map._generate()
	
	var start = InfoRoom.new(self.StartScene)

	$Map.add_to_head(start)
	$Map.start()
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
	$Opening.enabled(false)
	$Opening.queue_free()

	$Player.visible = true
	$Player/HUD.enabled(true)

	var start = InfoRoom.new(self.StartScene)

	$Map.add_to_head(start)
	$Map.start()
	return
