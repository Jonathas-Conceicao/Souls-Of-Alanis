extends Node2D

const SPEED = 1000
var state = 0
var screensize

func _ready():
	screensize = get_viewport_rect().size
	pass

func _process(delta):
	var velocity = Vector2() # the player's movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite.animation = "moving"
	else:
		$AnimatedSprite.animation = "idle"