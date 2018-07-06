extends KinematicBody2D
# Preload classes
const Foe = preload ("res://script/Classes/Foe.gd")
const Attack = preload("res://script/Classes/Attack.gd")

const DamageShower = preload("res://HUD/Damage.tscn")

# Define constants
const UP = Vector2(0,-1)
const GRAVITY = 10

# Define signals
signal StateChanged
signal DataUpdated

# Define variables
var current_state = null
var BASE_SPEED = 150
var velocity = Vector2()
var direction = DIRECTIONS.RIGHT
var data

enum DIRECTIONS { RIGHT, LEFT }

onready var ray_right      = get_node( "RayCastRight")
onready var ray_left       = get_node( "RayCastLeft" )
onready var ray_right_down = get_node( "RayCastRightDown" )
onready var ray_left_down  = get_node( "RayCastLeftDown" )

onready var state = {
    "Stagger": $States/Stagger,
	"Walk":  $States/Walk,
}

func _ready():
    data = Foe.new()
    self.add_child(data)
    velocity.y = 40 # base velocity to detect "is_on_floor"
    current_state = state["Walk"]
    current_state.enter(self)
    emit_signal("StateChanged", current_state)
    emit_signal("DataUpdated", self)

    set_process(true)
    return

func _physics_process(delta):
	var new_state = current_state.update(self, delta)
	if new_state:
		_state_change(new_state)
	if is_on_floor() && velocity.y >= 0:
		velocity.y = 40
	else:
		velocity.y += GRAVITY
	move_and_slide(velocity, UP)
	return

func set_animation(animation):
	if !$Pivot/Animation.is_playing() || $Pivot/Body.animation != animation:
    	$Pivot/Body.animation = animation
    	$Pivot/Animation.play(animation)
	return

func getData():
    var data = []
    data.append(["State", self.current_state.get_name()])
    data.append(["HP", self.data.getHP()])
    data.append(["Stamina", self.data.getStamina()])
    return data

func get_size():
    return data.get_size()

func calcPercentage(h, l):
    return (l*100)/h

func _state_change(state_name):
    current_state.exit(self)
    var s = state[state_name]
    if s:
        current_state = s
    current_state.enter(self)
    emit_signal("StateChanged", current_state)
    return

func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	emit_signal("DataUpdated", self)
	var damageDisplay = DamageShower.instance()
	damageDisplay.init(self, $DamageSpot.get_position(), Vector2(1.5, 1.5), damage)
	self.add_child(damageDisplay)
	print("Mushroom recieved ", damage, " from: ", agressor.get_name())
	_state_change("Stagger")
	var dp = calcPercentage(self.data.getMaxHP(), damage)
	current_state.setKnockBack(self, dp, attack.direction)
	if data.getHP() <= 0:
		queue_free()
	return

func _on_takeFoot(agressor):
	queue_free()
	pass

func _on_Animation_animation_finished(anim_name):
  var ns = current_state._on_animation_finished(self, anim_name)
  if ns: _state_change(ns)
  return
