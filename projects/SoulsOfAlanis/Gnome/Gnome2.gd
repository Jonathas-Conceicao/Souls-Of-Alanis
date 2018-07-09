# GNOME - FOE
extends KinematicBody2D

const Foe     = preload ("res://script/Classes/Foe.gd")
const Attack  = preload ("res://script/Classes/Attack.gd")
const Bomb    = preload ("res://Gnome/Bomb.tscn")

const UP = Vector2(0,-1)
const GRAVITY = 20
const SPEED = 100
const MAXSPEED = 300
const FLIPPING_SCALE = Vector2(-1, 1)

enum MOVEMENTS  { IDLE, PATROL }
enum DIRECTIONS { RIGHT, LEFT }

var direction = LEFT
var flipped = false
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
  pass

func _physics_process(delta):
  update_velocity()
  act()
  pass

func act():
  if movement == PATROL:
    act_patrol()
  pass

func update_velocity():
  if is_on_floor() && velocity.y >= 0:
    velocity.y = 40
  else:
    velocity.y += GRAVITY
  move_and_slide(velocity, UP)

func _on_takeDamage(agressor, attack):
  var damage = data.takeAttack(attack)
  print("Gnome recived ", damage, " from: ", agressor.get_name())
  var dp = calcPercentage(self.data.getMaxHP(), damage)
  setKnockBack(self, dp, attack.direction)
  if data.getHP() <= 0:
    queue_free()
  pass

func act_patrol():
  var body = null
  if direction == DIRECTIONS.RIGHT:
    if not flipped:
      flipped = true
      $Pivot.apply_scale(FLIPPING_SCALE)
    if !ray_right.is_colliding() and ray_right_down.is_colliding():
      velocity.x = SPEED
    else:
      direction = DIRECTIONS.LEFT

  if direction == DIRECTIONS.LEFT:
    if flipped:
      flipped = false
      $Pivot.apply_scale(FLIPPING_SCALE)
    if !ray_left.is_colliding() and ray_left_down.is_colliding():
      velocity.x = -SPEED
    else:
      direction = DIRECTIONS.RIGHT

func act_idle():
     pass

func setKnockBack(host, itencity, direction):
  pass

func calcPercentage(h, l):
  return (l*100)/h
  
func foe():
  pass

func _on_HitBox_body_entered(body):
  if (body.has_method("_on_takeDamage") and (not(body.has_method("foe")))):
    var attack = data.genAttack()
    body._on_takeDamage(self, attack)


func _on_Timer_timeout():
  var bomb = Bomb.instance(direction)
  get_parent().add_child(bomb)
  var p = $Pivot.get_global_position()	
  if direction == LEFT:
    p.x += -20
  else:
    p.x += 20
  p.y -= 10
  bomb.set_position(p)
  pass # replace with function body
