extends KinematicBody2D

const Foe = preload ("res://script/Classes/Foe.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")

const DamageShower = preload("res://HUD/Damage.tscn")

const UP = Vector2(0,-1)
const GRAVITY = 10
const FLIPPING_SCALE = Vector2(-1, 1)
var BASE_SPEED = 200
var BASE_ENERGY = 80

var energy = BASE_ENERGY
var velocity = Vector2()

var direction
var flipped = false

signal StateChanged
signal DataUpdated
var current_state = null

onready var state = {
	"Idle":    $States/Idle,
	"Move":    $States/Move,
	"Stagger": $States/Stagger,
}

var data

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

func _input(event):
	var new_state = current_state.handle_input(self, event)
	if new_state:
		_state_change(new_state)
	return
	
func _physics_process(delta):
	var new_state = current_state.update(self, delta)
	if new_state:
		_state_change(new_state)
	move_and_slide(velocity, UP)
	return

func update_flip():
	direction = velocity.x >= 0
	if direction == flipped:
		$Body.apply_scale(FLIPPING_SCALE)
		flipped = !direction
	return

func _state_change(state_name):
	current_state.exit(self)
	var s = state[state_name]
	if s:
		current_state = s
	current_state.enter(self)
	emit_signal("StateChanged", current_state)
	return

func getData():
	var data = []
	data.append(["State", self.current_state.get_name()])
	data.append(["HP", self.data.getHP()])
	data.append(["Stamina", self.data.getStamina()])
	data.append(["Energy", self.energy])
	return data

#func _on_Animation_animation_finished(anim_name):
#	var ns = current_state._on_animation_finished(self, anim_name)
#	if ns: _state_change(ns)
#	return

func _on_Energy_timeout():
	var energy_per_tick = max(1, data.getMaxStamina() / 30)
	data.increaseStamina(energy_per_tick)
	emit_signal("DataUpdated", self)
	return

func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	emit_signal("DataUpdated", self)
	var damageDisplay = DamageShower.instance()
	damageDisplay.init(self,
					   $DamageSpot.get_position(),
					   Vector2(1.5, 1.5),
					   damage)
	self.add_child(damageDisplay) # The label frees it self when finished
	print("Creature recived ", damage, " from: ", agressor.get_name())
	_state_change("Stagger")
	var dp = calcPercentage(self.data.getMaxHP(), damage)
	current_state.setKnockBack(self, dp, attack.direction)
	return

func calcPercentage(h, l):
	return (l*100)/h

func _on_Hit(body, id):
	if id == 0: return
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack()
		body._on_takeDamage(self, attack)
	return