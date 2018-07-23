extends Node2D

func _ready():
	$Sorcerer.enabled(false)
	$SorcererBossNPC.enabled(true)
	return

func _on_SorcererBossNPC_finished_dialog(host):
	$SorcererBossNPC.enabled(false)
	$Sorcerer.enabled(true)
	$Sorcerer.init(host)
	$SorcererBossNPC.queue_free()
	return
