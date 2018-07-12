extends Node2D

enum msg_type { nrm = 0, dbg = 1, err = 2, wrn = 3 }

func printDbg(msg, type = nrm, err = true):
	if err:
		match type:
			nrm:
				printerr("-> %s" % msg)
			dbg:
				printerr("(DB) %s" % msg)
			err:
				printerr("(EE) %s" % msg)
			wrn:
				printerr("(WW) %s" % msg)

	else:
		match type:
			nrm:
				print("-> %s" % msg)
			dbg:
				print("(DB) %s" % msg)
			err:
				print("(EE) %s" % msg)
			wrn:
				print("(WW) %s" % msg)
	pass