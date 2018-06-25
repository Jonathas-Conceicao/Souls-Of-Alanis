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
var BASE_SPEED = 200
var BASE_ENERGY = 80

var velocity = Vector2()
var direction
var flipped = false

var

var current_state = null

enum STATE { IDLE, MOVE, STAGGER }

var data

func _ready():
	data = Foe.new()
	self.add_child(data)
	velocity.y = 40 # base velocity to detect "is_on_floor"
	current_state = STATE.IDLE
	
	set_process(true)
	return

func _process(delta):
    updateState()
    return
	
func _physics_process(delta):
    move_and_slide(velocity, UP)
	return

func update_flip(flip):
	return

func updateState():
    if current_state == IDLE
	    stateIdle()
	if current_state == MOVE
	    stateMove()
	if current_state == STAGGER
	    stateStagger()
	return

func stateIdle():
    pass

func stateMove():
    pass

func stateStagger():
    pass

func set_animation(animation):
  if !$Animation.is_playing() || $Sprite.animation != animation:
    $Sprite.animation = animation # To solve bug where the new state commes before the Animation starts
    $Animation.play(animation)
    $Sword.animation_play(animation)
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

func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	var damageDisplay = DamageShower.instance()
	damageDisplay.init(self,
					   $DamageSpot.get_position(),
					   Vector2(1.5, 1.5),
					   damage)
	self.add_child(damageDisplay) # The label frees it self when finished
	print("Creature recived ", damage, " from: ", agressor.get_name())
	state = STAGGER
	var dp = calcPercentage(self.data.getMaxHP(), damage)
	setKnockBack(self, dp, attack.direction)
	return

func setKnockBack(host, itencity, direction):
	var multiplier = max(150, 3 * itencity)
	var direction = direction

	return

func update(host, delta):
	if not knockedBack:
		velocity = (multiplier * direction)
		knockedBack = true
	if host.is_on_ceiling():
		velocity.y = max(0, host.velocity.y)
	if host.is_on_floor() && host.velocity.y >= 0:
		current_state = IDLE
	if host.is_on_wall() && host.velocity.x != 0:
		current_state = IDLE
	host.velocity.y += host.GRAVITY
	return


func calcPercentage(h, l):
	return (l*100)/h

func _on_Hit(body, id):
	if id == 0: return
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack()
		body._on_takeDamage(self, attack)
	return
