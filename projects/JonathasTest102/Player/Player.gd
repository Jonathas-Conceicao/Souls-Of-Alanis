extends KinematicBody2D

const Hero = preload("res://script/Classes/Hero.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const Weapon = preload("res://script/Classes/Weapon.gd")

const UP = Vector2(0,-1)
const GRAVITY = 10
const FLIPPING_SCALE = Vector2(-1, 1)

const MAXSPEED = 350
const MAXENERGY = MAXSPEED * 1.5

var speed = 350
var direction
var velocity = Vector2()

var flipped = false
var state_flipped = false
var state_moving_x = false
var state_moving_y = false
var state_attacking = false
var state_leeping = false

var data

func _ready():
	data = Hero.new()
	self.add_child(data)
	data.setWeapon(Weapon.new(0, Attack.Slash, 20))
	set_process(true)
	set_process_input(true)

func _input(event):
	# Handle test actions
	if event.is_action_pressed("ui_debug"):
		processDebug()

	# Handle weapon swaping
	if   event.is_action_pressed("ui_select_weapon_0"):
		switchWeapon(0)
	elif event.is_action_pressed("ui_select_weapon_1"):
		switchWeapon(1)
	elif event.is_action_pressed("ui_select_weapon_2"):
		switchWeapon(2)

	# Handle attack
	if event.is_action_pressed("ui_attack"):
		handleAttack()

	# Handle moviment
	if   Input.is_action_pressed("ui_right"):
		handleMoviment(0)
	elif Input.is_action_pressed("ui_left"):
		handleMoviment(1)
	else:
		handleMoviment(2)

	if event.is_action_pressed("ui_up"):
		handleMoviment(3)
	elif event.is_action_pressed("ui_leep"):
		handleMoviment(4)
	else:
		handleMoviment(5)

func _physics_process(delta):
	update_hud()
	update_velocity()
	update_animation()
	move_and_slide(velocity, UP)

func processDebug():
	data.attributes.power.stamina += 10
	data.attributes.power.updateCurrent()
	print("Current Stamina:", data.getStamina())
	print("Max     Stamina:", data.getMaxStamina())

func switchWeapon(type):
	match type:
		0:
			data.setWeapon(Weapon.new(0, Attack.Slash, 20))
			print("Holding a Sword")
		1:
			data.setWeapon(Weapon.new(0, Attack.Impact, 20))
			print("Holding a Axe")
		2:
			data.setWeapon(Weapon.new(0, Attack.Thrust, 20))
			print("Holding a Spear")

func handleAttack():
	state_attacking = true

func handleMoviment(k):
	match k:
		0: # ui_right
			if not state_leeping:
				velocity.x = speed
				state_moving_x = true
				state_flipped = false
		1: # ui_left
			if not state_leeping:
				velocity.x = -speed
				state_moving_x = true
				state_flipped = true
		2: # not moving x
			if not state_leeping:
				velocity.x = 0
				state_moving_x = false
		3: # ui_up
			if is_on_floor():
				velocity.y = -speed
				state_moving_y = true
			elif is_on_wall():
				velocity.y = -data.getStamina()
				data.setStamina(0)
				state_moving_y = true
		4: # ui_leep
			var energy = data.getStamina()
			if is_on_floor():
				if state_flipped:
					velocity.x = - energy
				else:
					velocity.x = energy
				velocity.y = -energy
				data.setStamina(0)
				state_moving_x = true
				state_moving_y = true
				state_leeping = true
		5: # not moving y
			state_moving_y = false

func update_velocity():
	if is_on_floor() && velocity.y >= 0:
		velocity.y = 40
		state_moving_y = false
		state_leeping = false
		if state_leeping:
			velocity.x = 0
			state_moving_x = false
			state_leeping = false
	else:
		velocity.y += GRAVITY
		if is_on_ceiling():
			velocity.y = 0
		state_moving_y = true
	if not state_moving_x:
		velocity.x = 0

func update_animation():
	if state_attacking:
		set_animation("Attaking")
	else:
		update_flip()
		if state_moving_y:
			if velocity.y <= 0:
				set_animation("Jumping")
			else:
				set_animation("Falling")
		elif state_moving_x:
			if velocity.x != 0:
				set_animation("Moving")
		else:
			set_animation("Idle")

func update_flip():
	if state_flipped != flipped:
		$Sprite.apply_scale(FLIPPING_SCALE)
		$Sword.animation_flip()
		flipped = state_flipped

func update_hud():
	var hpMax = data.getMaxHP()
	var hpCur = data.getHP()
	var hpP = calcPercentage(hpMax, hpCur)
	var stMax = data.getMaxStamina()
	var stCur = data.getStamina()
	var staminaP = calcPercentage(stMax, stCur)
	$HUD.setHP(hpP)
	$HUD.setStamina(staminaP)

func calcPercentage(h, l):
	return (l*100)/h

func set_animation(animation):
	if !$Animation.is_playing() || $Sprite.animation != animation:
		$Animation.play(animation)
		$Sword.animation_play(animation)

func _on_Animation_animation_finished(anim_name):
	if $Sprite.animation == "Attaking":
		state_attacking = false

func _on_Energy_timeout():
	var energy = data.getStamina()
	var energy_per_tick = max(1, data.getMaxStamina() / 30)
	data.setStamina(energy + energy_per_tick)

func _on_takeDamage(agressor, attack):
	var damage = data.takeAttack(attack)
	print("Player recived ", damage, " from: ", agressor.get_name())

func _on_SwordHit(body, id):
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack()
		body._on_takeDamage(self, attack)

func _on_Stepping_body_entered(body):
	if body != self && body.has_method("_on_takeFoot"):
		body._on_takeFoot(self)
