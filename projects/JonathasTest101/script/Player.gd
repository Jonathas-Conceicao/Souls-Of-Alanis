extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 150
var velocity = Vector2()

var attaking = false

func _physics_process(delta):
	velocity.y += GRAVITY
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -350
	if Input.is_action_just_pressed("ui_attak") && !attaking:
		attaking = true
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
	else:
		velocity.x = 0
	updateAnimation()
	move_and_slide(velocity, UP)

func updateAnimation():
	if attaking:
		if $Sprite.animation != "Attaking":
			$Animation.play("Attaking")
	elif is_on_floor():
		if velocity.x != 0:
			if $Sprite.animation != "Moving":
				$Animation.play("Moving")
		else:
			if $Sprite.animation != "Idle":
				$Sword.Animation_idle()
				$Animation.play("Idle")
	else:
		if velocity.y <= 0:
			if $Sprite.animation != "Jumping":
				$Animation.play("Jumping")
		else:
			if $Sprite.animation != "Falling":
				$Animation.play("Falling")

func _on_Animation_animation_finished(anim_name):
	if $Sprite.animation == "Attaking":
		attaking = false
