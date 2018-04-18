extends AnimatedSprite

const FLIPPING_SCALE = Vector2(-1,1)

func _ready():
	$Animation.play("Idle")
	return

func animation_play(animation):
	$Animation.play(animation)

func animation_flip():
	self.apply_scale(FLIPPING_SCALE)