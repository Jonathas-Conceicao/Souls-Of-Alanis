extends KinematicBody2D
# Preload classes
const Foe = preload ("res://script/Classes/Foe.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")
const Bomb = preload("Bomb.tscn")

const DamageShower = preload("res://HUD/Damage.tscn")

# Define constants
const UPVEC = Vector2(0,-1)
const GRAVITY = 500
const FLIPPING_SCALE = Vector2(-1, 1)

# Define signals
signal StateChanged
signal DataUpdated

# Define variables
var current_state = null
var BASE_SPEED = 150
var velocity = Vector2()
var direction = DIRECTIONS.RIGHT
var flipped = false
var data

enum DIRECTIONS { LEFT, RIGHT }

onready var ray_right      = get_node( "Right")
onready var ray_left       = get_node( "Left" )
onready var ray_right_down = get_node( "RightDown" )
onready var ray_left_down  = get_node( "LeftDown" )

onready var state = {
    "Walk":    $States/Walk,
    "Stagger": $States/Stagger,
	"Death":   $States/Death,
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
	velocity.y += delta * GRAVITY
	var motion = velocity * delta
	var collision = move_and_collide(motion)
	if collision:
		velocity = velocity.slide(collision.normal)
		if collision.collider.has_method("_on_takeDamage"):
			if direction == DIRECTIONS.LEFT:
				direction = DIRECTIONS.RIGHT
			else:
				direction = DIRECTIONS.LEFT
			var attack = data.genAttack()
			collision.collider._on_takeDamage(self, attack)
	return
	
#  Function to generate artificial inputs to change states
#  This function will be called according to the Creature's AI,
# for instance, it can be called everytime a Timer ends up
func inputAI():
    #  Here goes the generation of an input
    # and the insertion of this input on the
    # event variable
    # << BEGIN
    var event
    # END >>
    var new_state = current_state.handle_inputIA(self, event)
    if new_state:
        _state_change(new_state)
    return

func set_animation(animation):
	if !$Pivot/Animation.is_playing() || $Pivot/Body.animation != animation:
    	$Pivot/Body.animation = animation # To solve bug where the new state commes before the Animation starts
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
	print("Goblin recieved ", damage, " from: ", agressor.get_name())
	_state_change("Stagger")
	var dp = calcPercentage(self.data.getMaxHP(), damage)
	current_state.setKnockBack(self, dp, attack.direction)
	if data.getHP() <= 0:
		_state_change("Death")
	return

func _on_Animation_animation_finished(anim_name):
  var ns = current_state._on_animation_finished(self, anim_name)
  if ns: _state_change(ns)
  return

func _on_Timer_timeout():
	var dir = 1
	if direction == LEFT:
		dir = -1
	var bomb = Bomb.instance(dir)
	get_tree().get_root().add_child(bomb)
	var p = $Pivot.get_global_position()
	p.x += 20 * dir
	p.y -= 20
	bomb.set_position(p)
	pass
