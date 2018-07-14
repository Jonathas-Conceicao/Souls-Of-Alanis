extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

enum msg_type { nrm = 0, dbg = 1, wrn = 2, err = 3 }

const DEBUG_MODE = false
var i_Prelude = preload("res://script/map/InfoRoom.gd").new("res://scene/Prelude.tscn", RoomType.ordinary, Half.first, 1, Vector2(2,4.2))

func _init():
	return

func printMsg(msg, type = msg_type.wrn, debug = DEBUG_MODE, err = true):
	if err:
		match type:
			nrm:
				if debug:
					printerr("-> %s" % msg)
			dbg:
				if debug:
					printerr("(DB) %s" % msg)
			wrn:
				printerr("(WW) %s" % msg)
			err:
				printerr("(EE) %s" % msg)

	else:
		match type:
			nrm:
				if debug:
					print("-> %s" % msg)
			dbg:
				if debug:
					print("(DB) %s" % msg)
			wrn:
				print("(WW) %s" % msg)
			err:
				print("(EE) %s" % msg)
	return