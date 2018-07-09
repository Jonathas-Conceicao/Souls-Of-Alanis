extends KinematicBody2D
# Preload classes
const Foe = preload ("res://script/Classes/Foe.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")

const DamageShower = preload("res://HUD/Damage.tscn")

# Define constants
const UP = Vector2(0,-1)
const GRAVITY = 10
const FLIPPING_SCALE = Vector2(-1, 1)

# Define signals
signal StateChanged
signal DataUpdated

# Define variables
var current_state = null
var BASE_SPEED = 150
var velocity = Vector2()
var direction
var flipped = false
var data

onready var state = {
    "Idle":    $States/Idle,
    "Stagger": $States/Stagger,
}

func _ready():
    data = Foe.new()
    self.add_child(data)
    velocity.y = 40 # base velocity to detect "is_on_floor"
    current_state = state["Idle"]
    current_state.enter(self)
    emit_signal("StateChanged", current_state)
    emit_signal("DataUpdated", self)

    set_process(true)
    return

func _physics_process(delta):
    var new_state = current_state.update(self, delta)
    if new_state:
        _state_change(new_state)
    move_and_slide(velocity, UP)
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

func update_flip():
    direction = velocity.x >= 0
    if direction == flipped:
        $Pivot/Body.apply_scale(FLIPPING_SCALE)
        flipped = !direction
    return

func set_animation(animation):
	if !$Animation.is_playing() || $Pivot/Body.animation != animation:
    	$Pivot/Body.animation = animation # To solve bug where the new state commes before the Animation starts
    	$Animation.play(animation)
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
	print("Creature recieved ", damage, " from: ", agressor.get_name())
	_state_change("Stagger")
	var dp = calcPercentage(self.data.getMaxHP(), damage)
	current_state.setKnockBack(self, dp, attack.direction)
	if data.getHP() <= 0:
		queue_free()
	return

func _on_Animation_animation_finished(anim_name):
  var ns = current_state._on_animation_finished(self, anim_name)
  if ns: _state_change(ns)
  return
