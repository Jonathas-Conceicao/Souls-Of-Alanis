extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 150
var velocity = Vector2()

enum Direction { RIGHT, LEFT }

onready var ray_right = get_node( "RayCastRight" )
onready var ray_left = get_node( "RayCastLeft" )

var dir = RIGHT

func _physics_process(delta):
	velocity.y += GRAVITY
	
	if dir == Direction.RIGHT:
		if ray_right.is_colliding():
			velocity.x = SPEED
		else:
			dir = Direction.LEFT
	
	if dir == Direction.LEFT:
		if ray_left.is_colliding():
			velocity.x = -SPEED
		else:
			dir = Direction.RIGHT
	
	move_and_slide(velocity, UP)
	
	pass