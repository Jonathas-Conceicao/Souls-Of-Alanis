extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 150
const FLIPPING_SCALE = Vector2(-1, 1)
var velocity = Vector2()

var attaking = false

var flipped = false

func _physics_process(delta):
  velocity.y += GRAVITY
  if is_on_floor():
    if Input.is_action_just_pressed("ui_up"):
      velocity.y = -350
  if Input.is_action_just_pressed("ui_attak") && !attaking:
    attaking = true
  if Input.is_action_pressed("ui_right"):
    velocity.x = SPEED
  elif Input.is_action_pressed("ui_left"):
    velocity.x = -SPEED
  else:
    velocity.x = 0
  update_animation()
  move_and_slide(velocity, UP)

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
