extends Node

enum Equipaments {Sword, Armor, Ring, Equipaments_size}
enum Consumables {Damage, Stamina, Defense, HP, Speed, Consumables_size}

const NO_DESCRIPTION = "No description"
const N_SPRITES = 5
const CONSUMABLE_DES = [
	"Temporary damage bonus",
	"Temporary stamina bonus",
	"Temporary defense bonus",
	"HP potion",
	"Temporary speed bonus"]

const Item = preload("res://Items/Item.gd")

const Consumable = preload("res://script/Classes/Consumable.gd")
const Weapon     = preload("res://script/Classes/Weapon.gd")
const Armor      = preload("res://script/Classes/Armor.gd")
const Ring       = preload("res://script/Classes/Ring.gd")

# const SELF = preload("res://script/tool/RandomItemGenerator.gd")

###
# Generates a random *Item* based on player level
# playerLevel -> Player's level so the data is proportional
# return: Item instance's scene
###
static func generateAny(playerLevel = 1):
	var coin = randi() % 2
	var newItem = generateEquipament(playerLevel) if coin == 0 else generateConsumable(playerLevel)
	return newItem

###
# Generates a random *Equipament* based on player level
# playerLevel -> Player's level so the data is proportional
# return: Item instance's scene
###
static func generateEquipament(playerLevel = 1):
	var newEquip = null
	newEquip = Item.new()
	var type
	var description
	var sprite
	var data
	type = randi() % Equipaments_size
	description = NO_DESCRIPTION
	sprite = randi() % N_SPRITES
	data = genData(type, playerLevel)
	newEquip.set_type(type)
	newEquip.set_sprite_id(sprite)
	newEquip.set_description(description)
	newEquip.set_data(data)
	return newEquip

static func generateConsumable(playerLevel = 1):
	var newConsumable = null
	newConsumable = Item.new()
	var type
	var subType
	var description
	var sprite
	var data
	type = Item.Type.Consumable
	subType = randi() % CONSUMABLE_DES.size()
	description = CONSUMABLE_DES[subType]
	sprite = subType
	data = genData(type, playerLevel, subType)
	newConsumable.set_type(type)
	newConsumable.set_sprite_id(sprite)
	newConsumable.set_description(description)
	newConsumable.set_data(data)
	return newConsumable

static func genData(type, playerLevel, subType = 0):
	var data = null
	match type:
		Item.Type.Sword:
			var weight = (randi() % 3) + 1 # Light, Medium, Heavy
			data = Weapon.new(weight * weightByLevel(playerLevel), 0, combatByLevel(playerLevel) / weight)
		Item.Type.Armor:
			var d1 = (randi() % 3) + 1
			var d2 = (randi() % 3) + 1
			var d3 = (randi() % 3) + 1
			var combat = combatByLevel(playerLevel)
			data = Armor.new(weightByLevel(playerLevel), d1 * combat, d2 * combat, d3 * combat)
		Item.Type.Ring:
			var bonus = [0, 0, 0, 0, 0, 0, 0] # hp, st, cl, xp, s, i, t
			var selected = randi() % 7
			bonus[selected] = powerByLevel(playerLevel)
			data = Ring.new(bonus[0], bonus[1], bonus[2], bonus[3], bonus[4], bonus[5], bonus[6])
		_:
			var value
			value = usableByLevel(playerLevel, subType)
			data = Consumable.new(subType, value, 60)
	return data

static func weightByLevel(playerLevel):
	return 1 * playerLevel

static func combatByLevel(playerLevel):
	return 10 * playerLevel

static func powerByLevel(playerLevel):
	return 1 * playerLevel

static func usableByLevel(playerLevel, type):
	var bonus
	match type:
		Consumables.Damage:
			bonus = 10
		Consumables.Stamina:
			bonus = 25
		Consumables.Defense:
			bonus = 10
		Consumables.HP:
			bonus = 25
		Consumables.Speed:
			bonus = 100
	return bonus * playerLevel
