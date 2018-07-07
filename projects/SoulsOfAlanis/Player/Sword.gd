extends AnimatedSprite

const FLIPPING_SCALE = Vector2(-1,1)
var Holder

func _ready():
	$Animation.play("Idle")
	Holder = self.get_parent()
	return

func animation_play(animation):
	$Animation.play(animation)
	return

func animation_flip():
	self.apply_scale(FLIPPING_SCALE)
	return

func _on_Hitbox_body_entered(body):
	if Holder.has_method("_on_SwordHit_body"):
		Holder._on_SwordHit_body(body)
	return

func _on_Hitbox_area_entered(area):
	if Holder.has_method("_on_SwordHit_area"):
		Holder._on_SwordHit_area(area)
	return
