extends KinematicBody2D

signal StateChanged
signal DataUpdated

const Foe = preload("res://script/Classes/Foe.gd")
const Attack = preload("res://script/Classes/Attack.gd")

const DamageShower = preload("res://HUD/Damage.tscn")

const UP = Vector2(0,-1)
const GRAVITY = 10
const FLIPPING_SCALE = Vector2(-1, 1)
const SPEED = 250

var velocity = Vector2(0, 0)
var current_state
var data

var flipped = false
var seek

onready var state = {
	"Lost":       $States/Lost,
	"Seek":       $States/Seek,
	"Destroy":    $States/Destroy,
	"DeathFromAbove": $States/DeathFromAbove,
}

func _ready():
	self.data = self.newData()
	self.add_child(data)
	velocity.y = 40 # base velocity to detect "is_on_floor"

	current_state = state["Lost"]
	current_state.enter(self)
	emit_signal("StateChanged", current_state)
	emit_signal("DataUpdated", self)

	set_process(true)
	return

func newData():
	var data = Foe.new(Attack.Thrust)
	data.attributes.vitality += 6
	data.attributes.strength += 6
	data.attributes.agility  += 6
	return data

func _physics_process(delta):
	for body in $DamegeArea.get_overlapping_bodies():
		self.deathTo(body, self.aux_pos())
	if $Eyes/Right.is_colliding() || !$Eyes/FRight.is_colliding():
		current_state.handle_input(self, 0)
	elif $Eyes/Left.is_colliding() || !$Eyes/FLeft.is_colliding():
		current_state.handle_input(self, 1)
	
	var new_state = current_state.update(self, delta)
	if new_state:
		_state_change(new_state)
	move_and_slide(velocity, UP)
	return

func update_flip():
	if velocity.x >= 0 != flipped:
		self.apply_scale(FLIPPING_SCALE)
		flipped = not flipped
	return

func set_animation(animation):
	if !$Animation.is_playing() || $Sprite.animation != animation:
		$Sprite.animation = animation
		$Animation.play(animation)
	return

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
	damageDisplay.init(self,
					   $DamageSpot.get_position(),
					   Vector2(1.5, 1.5),
					   damage)
	self.add_child(damageDisplay)
	print("Sorcerer recieved ", damage,
		  " from: ", agressor.get_name())
	return

func calcPercentage(h, l):
	return (l*100)/h

func callThunder():
	if seek && current_state.has_method("callThunder"):
		self.current_state.callThunder(self, seek)
	return

func deathTo(body, pos):
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack(self.genPushBack(body, pos))
		body._on_takeDamage(self, attack)
	return

func genPushBack(body, pos):
	var v = body.get_global_position() - pos
	return v.normalized()

func _on_Finder_body_entered(body):
	if body.get_name() == "Player":
		self.seek = body
		var s = current_state.handle_input(self, 2)
		if s:
			_state_change(s)
	return

func _on_PlayerCast_body_entered(body):
	if body.get_name() == "Player":
		var ns = current_state.handle_input(self, 3)
		if ns: _state_change(ns)
	return

func _on_Animation_animation_finished(anim_name):
	var ns = current_state._on_animation_finished(self, anim_name)
	if ns: _state_change(ns)
	return

func _on_Thunder_body_entered(body):
	self.deathTo(body, $Thunder.get_global_position())

func _on_DamegeArea_body_entered(body):
	self.deathTo(body, self.aux_pos())

func aux_pos():
	return self.get_global_position() - Vector2(0, - 100)
