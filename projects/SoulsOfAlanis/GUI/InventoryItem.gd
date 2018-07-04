extends Control

enum Type {Sword, Armor, Ring, Usable}

const Armor  = preload("res://script/Classes/Armor.gd")
const DataWeapon = preload("res://script/Classes/Weapon.gd")
const Ring   = preload("res://script/Classes/Ring.gd")

export(Type)   var type = Type.Sword
export(String) var description = ""
export(int)    var SpriteID = 0
var data

func _ready():
	var texture = load(self.gen_texture_res())
	$Texture.set_texture(texture)
	return

func gen_texture_res():
	var res = "res://GUI/"
	match self.type:
		Type.Sword:
			res += "art/Sword_" + String(self.SpriteID) + "_Icon_GUI.png"
		Type.Armor:
			res += "art/Armor_" + String(self.SpriteID) + "_Icon_GUI.png"
		Type.Ring:
			res += "art/Ring_" + String(self.SpriteID) + "_Icon_GUI.png"
		Type.Usable:
			res += "art/Usable_" + String(self.SpriteID) + "_Icon_GUI.png"
	var check = File.new()
	var ok = check.file_exists(res)
	if ok:
		return res
	else:
		return "res://GUI/art/NotFound_Icon_GUI.png"
func init(data):
	self.data = data
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
