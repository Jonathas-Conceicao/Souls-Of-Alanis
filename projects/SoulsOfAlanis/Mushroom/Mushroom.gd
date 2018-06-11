# MUSHROOM - FOE
extends KinematicBody2D

const Foe = preload ("res://script/Classes/Foe.gd")
const Attack = preload ("res://script/Classes/Attack.gd")

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 150
const MAXSPEED = 300

enum MOVEMENTS  { IDLE, PATROL }
enum DIRECTIONS { RIGHT, LEFT }

var direction = RIGHT
var movement = PATROL
var velocity = Vector2()

var data

onready var ray_right      = get_node( "RayCastRight")
onready var ray_left       = get_node( "RayCastLeft" )
onready var ray_right_down = get_node( "RayCastRightDown" )
onready var ray_left_down  = get_node( "RayCastLeftDown" )
onready var ray_up         = get_node ("RayCastUp")

func _ready():
	data = Foe.new(Attack.Slash, Foe.Ground)
	self.add_child(data)
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

func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	print("Mushroom recived ", damage, " from: ", agressor.get_name())
	var dp = calcPercentage(self.data.getMaxHP(), damage)
	setKnockBack(self, dp, attack.direction)
	return

func _on_takeFoot(agressor):
	queue_free()
	pass

func act_patrol():
	var body = null
	if direction == DIRECTIONS.RIGHT:
		if !ray_right.is_colliding() and ray_right_down.is_colliding():
			velocity.x = SPEED
		else:
			if ray_right.is_colliding():
				body = ray_right.get_collider()
				if(body):
					if (body.has_method("_on_takeDamage") && (!(body.has_method("foe")))):
						if body != self && body.has_method("_on_takeDamage"):
							var attack = data.genAttack()
							body._on_takeDamage(self, attack)
							direction = DIRECTIONS.LEFT
					else:
						if (body.get_class() != "Area2D"):
							direction = DIRECTIONS.LEFT
			else:
				direction = DIRECTIONS.LEFT

	if direction == DIRECTIONS.LEFT:
		if !ray_left.is_colliding() and ray_left_down.is_colliding():
			velocity.x = -SPEED
		else:
			if ray_left.is_colliding():
				body = ray_left.get_collider()
				if(body):
					if (body.has_method("_on_takeDamage") && (!(body.has_method("foe")))):
						if body != self && body.has_method("_on_takeDamage"):
							var attack = data.genAttack()
							body._on_takeDamage(self, attack)
							direction = DIRECTIONS.RIGHT
					else:
						if (body.get_class() != "Area2D"):
							direction = DIRECTIONS.RIGHT
			else:
				direction = DIRECTIONS.RIGHT

func setKnockBack(host, itencity, direction):
	pass

func calcPercentage(h, l):
	return (l*100)/h
	
func act_idle():
     pass

func get_size():
	return data.get_size()
	
func foe():
	pass