extends Control

enum Type {Sword, Armor, Ring, Consumable}

## const Armor  = preload("res://script/Classes/Armor.gd")
## const DataWeapon = preload("res://script/Classes/Weapon.gd")
## const Ring   = preload("res://script/Classes/Ring.gd")

export(Type)   var type = Type.Sword
export(String) var description = ""
export(int, 0, 4)    var SpriteID = 0

var selected = false
var used = false

func _ready():
	var texture = self.gen_texture_res()
	$Texture.set_texture(texture)
	return

func init(t, desc, sid):
	self.set_type(t)
	self.set_description(desc)
	self.set_sprite_id(sid)
	return

func gen_texture_res():
	var res = "res://GUI/"
	match self.type:
		Type.Sword:
			res += "art/Sword_" + str(self.SpriteID) + "_Icon_GUI.png"
		Type.Armor:
			res += "art/Armor_" + str(self.SpriteID) + "_Icon_GUI.png"
		Type.Ring:
			res += "art/Ring_" + str(self.SpriteID) + "_Icon_GUI.png"
		Type.Consumable:
			res += "art/Consumable_" + str(self.SpriteID) + "_Icon_GUI.png"
	var check = File.new()
	var ok = check.file_exists(res)
	if ok:
		return load(res)
	return load("res://GUI/art/NotFound_Icon_GUI.png")

func disabled(b):
	$Texture.visible = !b
	return

func set_sprite_id(sid):
	self.SpriteID = sid
	return

func set_description(desc):
	self.description = desc
	return

func set_type(t):
	self.type = t
	return

func get_type():
	return self.type

func get_description():
	return self.description
