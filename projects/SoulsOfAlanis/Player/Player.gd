extends KinematicBody2D

const Hero = preload("res://script/Classes/Hero.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")

const DamageShower = preload("res://HUD/Damage.tscn")

const UP = Vector2(0,-1)
const GRAVITY = 10
const FLIPPING_SCALE = Vector2(-1, 1)
# export(float) var BASE_SPEED = 350
# export(float) var BASE_ENERGY = 250
var BASE_SPEED = 350
var BASE_ENERGY = 180

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
  "Jump":    $States/Jump,
  "Fall":    $States/Fall,
  "Leep":    $States/Leep,
  "Climb":   $States/Climb,
  "Attack":  $States/Attack,
  "Swap":    $States/Swap,
  "Stagger": $States/Stagger,
}

var data

func _ready():
  data = Hero.new()
  self.add_child(data)
  data.setWeapon(Weapon.new(0, Attack.Slash, 15))
  velocity.y = 40 # base velocity to detect "is_on_floor"
  current_state = state["Idle"]
  current_state.enter(self)
  emit_signal("StateChanged", current_state)
  emit_signal("DataUpdated", self)

  set_process(true)
  set_process_input(true)
  return

func _input(event):
  # Handle test actions
  if event.is_action_pressed("player_debug"):
    processDebug()

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

var control = 0
func processDebug():
  # _state_change("Idle")
  # data.attributes.power.stamina += 10
  # data.attributes.strength += 1
  # data.attributes.power.updateCurrent()
  # print("Strength       :", data.attributes.strength)
  # print("Current Stamina:", data.getStamina())
  # print("Max     Stamina:", data.getMaxStamina())
  # self._on_takeDamage(self, Attack.new(Attack.Slash, control))
  # control += 5
  # if control >= 20: control = 0
  # # var Cam = self.get_node("Camera2D")
  # Cam.zoom = (Cam.zoom - Vector2(0.1, 0.1))
  # for i in range(0, 4):
  # 	self.data.levelUp()
  return

func update_flip():
  direction = velocity.x >= 0
  if direction == flipped:
    $Sprite.apply_scale(FLIPPING_SCALE)
    $Sword.animation_flip()
    flipped = !direction
  return

func update_speed(nspeed):
	$Animation.set_speed_scale(nspeed)
	$Sword/Animation.set_speed_scale(nspeed)
	return

func set_animation(animation):
  if !$Animation.is_playing() || $Sprite.animation != animation:
    $Sprite.animation = animation # To solve bug where the new state commes before the Animation starts
    $Animation.play(animation)
    $Sword.animation_play(animation)
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

func _on_Animation_animation_finished(anim_name):
  var ns = current_state._on_animation_finished(self, anim_name)
  if ns: _state_change(ns)
  return

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
  print("Player recived ", damage, " from: ", agressor.get_name())
  _state_change("Stagger")
  var dp = calcPercentage(self.data.getMaxHP(), damage)
  current_state.setKnockBack(self, dp, attack.direction)
  return

func calcPercentage(h, l):
  return (l*100)/h

func _on_SwordHit(body):
  if body != self && body.has_method("_on_takeDamage"):
    var attack = data.genAttack()
    body._on_takeDamage(self, attack)
  return

func _on_Stepping_body_entered(body):
  if body != self && body.has_method("_on_takeFoot"):
    body._on_takeFoot(self)
  return
