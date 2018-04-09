extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 150
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
		
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED	
		$sprite.flip_h = false
		$sprite.play("moving")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		$sprite.flip_h = true
		$sprite.play("moving")
	else:
		motion.x = 0
		$sprite.play("idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -350
			$sprite.play("jumping")
	else:
		$sprite.play("jumping")
		
	motion = move_and_slide(motion, UP)

