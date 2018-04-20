extends AnimatedSprite

const FLIPPING_SCALE = Vector2(-1,1)

func _ready():
	$Animation.play("Idle")
	return

func animation_play(animation):
	$Animation.play(animation)

func animation_flip():
	self.apply_scale(FLIPPING_SCALE)

func _on_Hitbox_body_entered(body):
	if body.has_method("_on_meele_hit"):
		body._on_meele_hit($Hitbox)

func _on_TrailBox_body_entered(body):
	if body.has_method("_on_meele_hit"):
		body._on_meele_hit($TrailBox)
