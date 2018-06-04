# GNOME - FOE
extends KinematicBody2D

const Foe = preload ("res://script/classes/Foe.gd")
const Attack = preload ("res://script/classes/Attack.gd")

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 100
const MAXSPEED = 300
const FLIPPING_SCALE = Vector2(-1, 1)

enum MOVEMENTS  { IDLE, PATROL }
enum DIRECTIONS { RIGHT, LEFT }

var direction = LEFT
var movement = PATROL
var velocity = Vector2()

var data

onready var ray_right      = get_node( "RayCastRight")
onready var ray_left       = get_node( "RayCastLeft" )
onready var ray_right_down = get_node( "RayCastRightDown" )
onready var ray_left_down  = get_node( "RayCastLeftDown" )


func _ready():
	data = Foe.new(Attack.Slash, Foe.Ground)
	self.add_child(data)
	set_process(true)
	pass

func _physics_process(delta):
	update_velocity()
	act()
	pass

func act():
	if movement == PATROL:
		act_patrol()
	if movement == IDLE:
		act_idle()
	pass

func update_velocity():
	if is_on_floor() && velocity.y >= 0:
		velocity.y = 40
	else:
		velocity.y += GRAVITY
	move_and_slide(velocity, UP)
	pass

func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	print("Gnome recived ", damage, " from: ", agressor.get_name())
	pass

func act_patrol():
	var shape = null
	if direction == DIRECTIONS.RIGHT:
		if !ray_right.is_colliding() and ray_right_down.is_colliding():
			velocity.x = SPEED
		else:
			if ray_right.is_colliding():
				shape = ray_right.get_collider()
				if (shape):
					if (shape.get_class() != "Area2D"):
						direction = DIRECTIONS.LEFT
						$Sprite.apply_scale(FLIPPING_SCALE)
			else:
				direction = DIRECTIONS.LEFT
				$Sprite.apply_scale(FLIPPING_SCALE)

	if direction == DIRECTIONS.LEFT:
		if !ray_left.is_colliding() and ray_left_down.is_colliding():
			velocity.x = -SPEED
		else:
			if ray_left.is_colliding():
				shape = ray_left.get_collider()
				if (shape):
					if (shape.get_class() != "Area2D"):
						direction = DIRECTIONS.RIGHT
						$Sprite.apply_scale(FLIPPING_SCALE)
			else:
				direction = DIRECTIONS.RIGHT
				$Sprite.apply_scale(FLIPPING_SCALE)

func act_idle():
     pass


func _on_CollisionShape2D_tree_entered(body):
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack()
		body._on_takeDamage(self, attack)
	pass # replace with function body
