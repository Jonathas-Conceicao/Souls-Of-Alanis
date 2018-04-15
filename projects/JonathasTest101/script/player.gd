extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 150
var motion = Vector2()

func _physics_process(delta):
	print("Delta value:", delta)
	motion.y += GRAVITY
	if is_on_floor():
		if $sprite.animation != "moving":
			$sprite.play("idle")
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -350
			$sprite.play("jumping")
#	elif $sprite.animation != "jumping" && $sprite.animation != "falling":
#		$sprite.play("falling")
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		$sprite.flip_h = false
		if $sprite.animation == "idle":
			$sprite.play("moving")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$sprite.flip_h = true
		if $sprite.animation == "idle":
			$sprite.play("moving")
	else:
		if $sprite.animation == "moving":
			$sprite.play("idle")
		motion.x = 0

	motion = move_and_slide(motion, UP)

func _on_sprite_animation_finished():
	if $sprite.animation == "jumping":
		$sprite.play("falling")
