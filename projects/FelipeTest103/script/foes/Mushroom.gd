extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 150
var velocity = Vector2()

enum Direction { RIGHT, LEFT }

enum STATE {
	IDLE,
	HITED
}

var state = IDLE

onready var ray_right = get_node( "RayCastRight")
onready var ray_left = get_node( "RayCastLeft" )
onready var ray_right_down = get_node( "RayCastRightDown" )
onready var ray_left_down = get_node( "RayCastLeftDown" )
onready var ray_up = get_node ("RayCastUp")

var dir = RIGHT

func _ready():
	state = IDLE

func _physics_process(delta):
	var shape = null
	velocity.y += GRAVITY

	if dir == Direction.RIGHT:

		if !ray_right.is_colliding() and ray_right_down.is_colliding():
			velocity.x = SPEED
		else:
			if ray_right.is_colliding():
				shape = ray_right.get_collider()
				if (shape.get_class() != "Area2D"):
					dir = Direction.LEFT
			else:
				dir = Direction.LEFT

	if dir == Direction.LEFT:
		if !ray_left.is_colliding() and ray_left_down.is_colliding():
			velocity.x = -SPEED
		else:
			if ray_left.is_colliding():
				shape = ray_left.get_collider()
				if (shape.get_class() != "Area2D"):
					dir = Direction.RIGHT
			else:
				dir = Direction.RIGHT

	if (ray_up.is_colliding()):
		shape = ray_up.get_collider()
		if (shape):
			if (shape.get_class() != "Area2D"):
				queue_free()

	move_and_slide(velocity, UP)

	pass

func _on_meele_hit(hitter):
	state = HITED
	pass

func _on_foot(hitter):
	queue_free()
	pass
