extends Node2D

var GhostBillNPCIdentifier = preload("res://scene/NPC/GhostBill/GhostBillNPCIdentifier.gd")


func set_enabled(value):
	if !value:
		$InteractAreaBill/AnimatedSprite.hide()
		$InteractAreaBill/CollisionShape2D.set_disabled(true)

	else:
		$InteractAreaBill/AnimatedSprite.show()
		$InteractAreaBill/CollisionShape2D.set_disabled(false)

func get_uniqueID():
	var aux = GhostBillNPCIdentifier.new()
	var auxID = aux.get_uniqueID()
	aux.queue_free()
	return auxID
