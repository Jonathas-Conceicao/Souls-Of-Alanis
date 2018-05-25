extends AnimatedSprite

const FLIPPING_SCALE = Vector2(-1,1)
var Holder

func _ready():
	$Animation.play("Idle")
	Holder = self.get_parent()
	return

func animation_play(animation):
	$Animation.play(animation)

func animation_flip():
	self.apply_scale(FLIPPING_SCALE)

#func _on_Hitbox_body_entered(body):
#	if Holder.has_method("_on_SwordHit"):
#		Holder._on_SwordHit(body, 0)

func _on_TrailBox_body_entered(body):
	if Holder.has_method("_on_SwordHit"):
		Holder._on_SwordHit(body, 1)
