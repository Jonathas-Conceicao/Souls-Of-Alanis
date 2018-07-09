extends Area2D

const SPEED = 250
var motion = Vector2(1, 0)
var damage = 10
var attack

enum DIRECTIONS { LEFT, RIGHT }

const Attack = preload ("res://script/Classes/Attack.gd")

func _ready(direction):
	match direction:
		RIGHT:
			motion.x = 1
		LEFT:
			motion.x = -1
	pass

func _process(delta):
	translate(motion * SPEED * delta)
	pass

func _on_Bomb_body_entered(body):
	create_explosion(body)
	$Body.play("boom")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
	pass # replace with function body

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	pass # replace with function body

func create_explosion(body):
	attack = Attack.new(Attack.Impact, damage, motion.x, -1)
	self.add_child(attack)
	if body.has_method("_on_SwordHit"):
		body._on_takeDamage(self, attack)
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	pass # replace with function body
