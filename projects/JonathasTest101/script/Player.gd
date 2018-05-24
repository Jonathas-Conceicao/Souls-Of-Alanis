extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 350
const FLIPPING_SCALE = Vector2(-1, 1)
var velocity = Vector2()
var energy = SPEED
var energy_ps    = SPEED/5

var attribute_vit
var attribute_for
var attribute_agi
var attribute_wis

var power_hp
var power_stamina
var power_carryLoad
var power_defense_slash
var power_defense_impact
var power_defense_thrust


var attaking = false
var leeping = false

var flipped = false

func _physics_process(delta):
	update_velocity()
	update_animation()
	move_and_slide(velocity, UP)

func update_velocity():
	if is_on_floor():
		velocity.y = 40
		leeping = false
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = - SPEED
	else:
		velocity.y += GRAVITY
		if is_on_ceiling():
			velocity.y = 0
	if is_on_wall():
		if Input.is_action_pressed("ui_up"):
			velocity.y -= energy
			energy = 0
	if Input.is_action_just_pressed("ui_attak") && !attaking:
		attaking = true
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_just_pressed("ui_leep") && energy > (SPEED/2) && is_on_floor():
		if flipped:
			velocity.x -= energy
		else:
			velocity.x += energy
		velocity.y -= energy
		energy = 0
		leeping = true
	elif !leeping:
		velocity.x = 0

func update_animation():
	if velocity.x > 0 && !attaking:
		flip_animation(false)
	elif velocity.x < 0 && !attaking:
		flip_animation(true)
	if attaking:
		set_animation("Attaking")
	elif is_on_floor():
		if velocity.x != 0:
			set_animation("Moving")
		else:
			set_animation("Idle")
	else:
		if velocity.y <= 0:
			set_animation("Jumping")
		else:
			set_animation("Falling")

func flip_animation(b):
	if flipped != b:
		$Sprite.apply_scale(FLIPPING_SCALE)
		$Sword.animation_flip()
		flipped = b

func set_animation(animation):
	if !$Animation.is_playing() || $Sprite.animation != animation:
		$Animation.play(animation)
		$Sword.animation_play(animation)

func _on_Animation_animation_finished(anim_name):
	if $Sprite.animation == "Attaking":
		attaking = false


func _on_Energy_timeout():
	energy = min(energy + energy_ps, SPEED)



