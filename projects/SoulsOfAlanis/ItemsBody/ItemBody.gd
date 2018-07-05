extends KinematicBody2D

enum Type {Sword, Armor, Ring, Usable}

const UP = Vector2(0, 1)
const GRAVITY = 10

var velocity = Vector2(0, 0)

export var MIN_Y_LAUNCH = 250
export var MAX_Y_LAUNCH = 450
export var X_LAUNCH = 100
export (int, 1, 5) var sprite_id = 1
export (Type) var type = 0

func _ready():
	self.disabled(true)
	self.drop()
	return

func _physics_process(delta): # TODO make item stop moving after earching the floor
	if !is_on_floor():
		velocity.y += self.GRAVITY
	else:
		self.velocity.x = 0
		self.velocity.y = 40
	move_and_slide(self.velocity, UP)
	return

func gen_texture_res():
	var res = "res://ItemsBody/art/"
	match self.type:
		Type.Sword:
			res += "Sword_ItemBody_" + String(self.sprite_id) + ".png"
		Type.Armor:
			res += "Armor_ItemBody_" + String(self.sprite_id) + ".png"
		Type.Ring:
			res += "Ring_ItemBody_" + String(self.sprite_id) + ".png"
		Type.Usable:
			res += "Usable_ItemBody_" + String(self.sprite_id) + ".png"
	var check = File.new()
	var ok = check.file_exists(res)
	if ok:
		return load(res)
	return load("res://ItemsBody/art/NotFound_ItemBody.png")

func drop():
	var texture = self.gen_texture_res()
	$Sprite.set_texture(texture)
	var dir = randi() % 2
	self.velocity.x = self.X_LAUNCH * (1 if dir else -1)
	self.velocity.y = - rand_range(MIN_Y_LAUNCH, MAX_Y_LAUNCH)
	self.disabled(false)
	return

func disabled(b):
	$Collision.disabled = b
	$Collision.visible = !b
	$Sprite.visible = !b