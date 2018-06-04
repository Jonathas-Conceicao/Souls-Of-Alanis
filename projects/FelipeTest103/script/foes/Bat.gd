# Bat - Foe
extends KinematicBody2D

const Foe = preload("res://script/classes/Foe.gd")
const Attack = preload("res://script/classes/Attack.gd")

const MAXSPEED = 350
const UP = Vector2(0, 0)

enum MOVEMENTS  { IDLE, PATROL, SENTINEL }
enum DIRECTIONS { UP, DOWN, LEFT, RIGHT }

var speed = 350

var direction = RIGHT
var movement = PATROL
var velocity = Vector2(0, 0)

var data

func _ready():
	data = Foe.new(Attack.Slash, Foe.Air)
	self.add_child(data)
	set_process(true)
	$WaitTimer.start()
	pass

func _physics_process(delta):
    #update_animation()
	pass


func act():
	if movement == PATROL:
    	act_patrol()
	if movement == IDLE:
		act_idle()
	if movement == SENTINEL:
		act_sentinel()
	pass

func act_idle():
	pass

func act_patrol():
	var d
	d = randi()%5+1
	match d:
		1:
			direction = RIGHT
		2:
			direction = LEFT
		3:
			direction = UP
		4:
			direction = DOWN
	pass

func act_sentinel():
	pass

func update_velocity():
	match direction:
		RIGHT:
			velocity.x =  5
		LEFT:
			velocity.x = -5
		UP:
			velocity.y = -5
		DOWN:
			velocity.y =  5
 
func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	print ("Bat received ", damage, " from: ", agressor.get_name())
	pass

func update_position():
	set_position(get_position() + velocity)
	pass

func _on_CollisionShape2D_tree_entered():
	match direction:
			RIGHT:
				direction = LEFT
			LEFT:
				direction = RIGHT
			UP:
				direction = DOWN
			DOWN:
				direction = UP
	pass # replace with function body


func _on_WaitTimer_timeout():
	update_velocity()
	act()
	update_position()
	$WaitTimer.start()
	pass # replace with function body
