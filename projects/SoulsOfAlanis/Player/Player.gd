extends KinematicBody2D

signal StateChanged
signal DataUpdated
signal SceneExit

const Hero = preload("res://script/Classes/Hero.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")
const Armor  = preload("res://script/Classes/Armor.gd")

const StarterSword = preload("res://Items/predefined/StarterSword.gd")
const StarterArmor = preload("res://Items/predefined/StarterArmor.gd")

const DamageShower = preload("res://HUD/Damage.tscn")

const Item = preload("res://Items/Item.gd")

const UP = Vector2(0,-1)
const GRAVITY = 10
const FLIPPING_SCALE = Vector2(-1, 1)
const BASE_SPEED = 300
var SPEED = BASE_SPEED
var BASE_ENERGY = 180

var energy = BASE_ENERGY
var velocity = Vector2()

var direction
var flipped = false

var current_state = null

const BACKPACK_LIMIT = 15 # Change this requires change in Inventory'art to allow for showing more items.
var Backpack = []
# Sould be used as a mutable list of reference (index) to Backpack's items
var Equiped = [null, null, null] # Sword, Armor, Ring

###
# Lists to store info related to rooms,
# objectes added will be found by a get_uniqueID() method.
# The lists have a add method, but remove methods are not necessary
###
var Chests = []         # List of opened chests
var StartedQuests = []  # List of started quests
var FinishedQuests = [] # List of finished quests

onready var state = {
	"Idle":       $States/Idle,
	"Move":       $States/Move,
	"Jump":       $States/Jump,
	"Fall":       $States/Fall,
	"Leep":       $States/Leep,
	"Climb":      $States/Climb,
	"Attack":     $States/Attack,
	# "Swap":     $States/Swap,
	"Stagger":    $States/Stagger,
	"PlayerMenu": $States/PlayerMenu,
}

var data

func _ready():
	data = Hero.new()
	self.add_child(data)
	velocity.y = 40 # base velocity to detect "is_on_floor"
	self.give_starting_items()

	current_state = state["Idle"]
	current_state.enter(self)
	emit_signal("StateChanged", current_state)
	emit_signal("DataUpdated", self)

	set_process(true)
	set_process_input(true)
	return

func _input(event):
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

func get_data():
	return self.data

func get_data_for_display():
	var attributes = []
	var powers = []

	attributes.push_back(self.data.attributes.vitality)
	attributes.push_back(self.data.attributes.strength)
	attributes.push_back(self.data.attributes.agility)
	attributes.push_back(self.data.attributes.wisdom)

	powers.push_back(self.data.attributes.power.cur_hp)
	powers.push_back(self.data.attributes.power.cur_stamina)
	powers.push_back(self.data.attributes.power.cur_carryLoad)
	powers.push_back(self.data.attributes.power.xp_gain)

	var attack  = self.data.genAttack()
	var defense = self.data.genDefense()
	powers.push_back(attack.damage)
	powers.push_back(defense.slash)
	powers.push_back(defense.impact)
	powers.push_back(defense.thrust)
	attack.queue_free()
	defense.queue_free()
	return [attributes, powers]

func give_starting_items():
	var ss = StarterSword.new()
	var sa = StarterArmor.new()
	self.add_child(ss)
	self.add_child(sa)
	self.Equiped[0] = ss
	self.Equiped[1] = sa
	self.data.setWeapon(ss.get_data())
	self.data.setArmor(sa.get_data())
	return

func get_Backpack_views(): # TODO: BUG: @Jonathas Items are not showing after 7th slot
	var views = []
	for item in self.Backpack:
		views.push_back(item.gen_InventoryView())
	return views

func get_Equipament_views():
	var views = [null, null, null]
	for i in range(0, 3): # Equiped.size() should aways be 3
		if self.Equiped[i] != null:
			views[i] = self.Equiped[i].gen_InventoryView()
	return views

func use_from_Backpack(index):
	if index > (self.Backpack.size() - 1):
		return
	var item = self.Backpack[index]
	var i
	var ok
	match item.type:
		item.Type.Sword:
			ok = self.data.setWeapon(item.get_data())
			i = 0 # Sword Slot
		item.Type.Armor:
			ok = self.data.setArmor(item.get_data())
			i = 1 # Armor Slot
		item.Type.Ring:
			ok = self.data.setRing(item.get_data())
			i = 2 # Ring Slot
		item.Type.Consumable:
			item.get_data().apply(self.data)
			ok = false
			self.Backpack.remove(index)
	if ok: # If data swap was made, update internal state
		self.Backpack.remove(index)
		var target = self.Equiped[i]
		if target != null:
			self.Backpack.push_back(target)
		self.Equiped[i] = item
	emit_signal("DataUpdated", self)
	return

func drop_from_Backpack(index): # TODO: BUG: @Jonathas Items order semas stranger after a few removes, might be related to invisible items bug
	if index > (self.Backpack.size() - 1):
		return
	self.Backpack[index].queue_free()
	self.Backpack.remove(index)
	return

# WARNING: Private method, see find methods below
func find_id_in(uniqueID, list):
	var index = 0
	for item in list:
		if uniqueID == item.get_uniqueID():
			return index
		index += 1
		pass
	return -1

func find_in_Backpack(uniqueID):
	return self.find_id_in(uniqueID, self.Backpack)

func find_in_Chests(uniqueID):
	return self.find_id_in(uniqueID, self.Chests)

func find_in_StartedQuests(uniqueID):
	return self.find_id_in(uniqueID, self.StartedQuests)

func find_in_FinishedQuests(uniqueID):
	return self.find_id_in(uniqueID, self.FinishedQuests)

func add_to_Chests(obj):
	self.Chests.push_front(obj)
	return

func add_to_StartedQuests(obj):
	self.StartedQuests.push_front(obj)
	return

func add_to_FinishedQuests(obj):
	self.FinishedQuests.push_front(obj)
	return

func get_from_BackPack(index):
	return self.Backpack[index]

func get_from_Chests(index):
	return self.Chests[index]

func get_from_StartedQuests(index):
	return self.StartedQuests[index]

func get_from_FinishedQuests(index):
	return self.FinishedQuests[index]

# var control = 0
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

func update_speed():
	var carryPerc = calcPercentage(data.getMaxCarryLoad(), data.getCarryLoad())
	var nspeed = calcSpeed(carryPerc)
	$Animation.set_speed_scale(nspeed)
	$Sword/Animation.set_speed_scale(nspeed)
	self.SPEED = self.BASE_SPEED * nspeed;
	return

func calcSpeed(percentage):
	var x = 1 + (1 - (percentage/100.0)) / 2
	return x

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

func _on_item_pickUp(I):
	if self.Backpack.size() < self.BACKPACK_LIMIT:
		self.Backpack.push_back(I)
		self.add_child(I)
		return true
	return false

func _on_SwordHit_body(body):
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack()
		body._on_takeDamage(self, attack)
	return

func _on_SwordHit_area(area):
	if area != $Stepping && area.has_method("_on_takeHit"):
		area._on_takeHit(self)
	if area.has_method("_get_exit"):
		var x = area._get_exit()
		emit_signal("SceneExit", self, x)
	return

func _on_Stepping_body_entered(body):
	if body != self && body.has_method("_on_takeFoot"):
		body._on_takeFoot(self)
	return

func _on_Stepping_area_entered(area):
	if area != $Stepping && area.has_method("_on_takeFoot"):
		area._on_takeFoot(self)
	return

func _on_Player_DataUpdated(host):
	self.update_speed()
	return
