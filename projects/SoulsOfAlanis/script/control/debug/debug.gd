extends Node2D

enum RoomType {loot, ordinary, connection, mission, challenge, final, any, avoid}
enum Half { first, second , any }

enum msg_type { nrm, dbg, wrn, err	 }

const DEBUG_MODE = false
var i_Prelude = preload("res://script/map/InfoRoom.gd").new("res://scene/Prelude.tscn", RoomType.ordinary, Half.first, 1, Vector2(2,4.2))

func _init():
	return

func printMsg(msg, type = msg_type.nrm, debug = DEBUG_MODE, err = true):
	if err:
		match type:
			msg_type.nrm:
				if debug:
					printerr("-> %s" % msg)
			msg_type.dbg:
				if debug:
					printerr("(DB) %s" % msg)
			msg_type.wrn:
				printerr("(WW) %s" % msg)
			msg_type.err:
				printerr("(EE) %s" % msg)
			_:
				printerr("(UK) %s" % msg)

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