extends Node2D

enum msg_type { nrm = 0, dbg = 1, wrn = 2, err = 3 }

var debug_mode = true

func _init(dbg = true):
	self.debug_mode = dbg
	return

func printMsg(msg, type = msg_type.wrn, debug = self.debug_mode, err = true):
	if err:
		match type:
			nrm:
				if debug:
					printerr("-> %s" % msg)
			dbg:
				if debug:
					printerr("(DB) %s" % msg)
			wrn:
				if debug:
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
				if debug:
					print("(WW) %s" % msg)
			err:
				print("(EE) %s" % msg)
	return