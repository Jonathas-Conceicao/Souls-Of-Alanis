extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 10
const SPEED = 150
var velocity = Vector2()

enum Direction { RIGHT, LEFT }

onready var ray_right = get_node( "RayCastRight")
onready var ray_left = get_node( "RayCastLeft" )
onready var ray_right_down = get_node( "RayCastRightDown" )
onready var ray_left_down = get_node( "RayCastLeftDown" )
onready var ray_up = get_node( "RayCastUp" )


var dir = RIGHT

func _physics_process(delta):
	velocity.y += GRAVITY
	
	if dir == Direction.RIGHT:
		if !ray_right.is_colliding() and ray_right_down.is_colliding():
			velocity.x = SPEED
		else:
			dir = Direction.LEFT
	
	if dir == Direction.LEFT:
		if !ray_left.is_colliding() and ray_left_down.is_colliding():
			velocity.x = -SPEED
		else:
			dir = Direction.RIGHT
	
	if ray_up.is_colliding():
		queue_free()
	
	move_and_slide(velocity, UP)
	
	pass