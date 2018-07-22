extends Area2D

var Foe

func _ready():
	self.Foe = get_parent()
	return

func _on_Area2D_body_entered(body):
	if body.has_method("_on_takeDamage"):
		var attack = Foe.data.genAttack(self.genPushBack(body))
		body._on_takeDamage(self, attack)
	return

func genPushBack(body):
	var v = body.get_global_position() - Foe.get_global_position()
	return v.normalized()
