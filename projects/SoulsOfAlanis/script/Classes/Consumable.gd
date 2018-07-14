extends Node

enum Consumables {Damage, Stamina, Defense, HP, Speed}

const Power   = preload("Power.gd")   # Class reference
const Attack  = preload("Attack.gd")  # Class reference
const Defense = preload("Defense.gd") # Class reference

var type
var value
var duration

var power = null
var attack = null
var defense = null

func _init(type = HP, value = 1, duration = 0):
	self.type = type
	self.value = value
	self.duration = duration
	return self

func getDuration():
	return self.duration

func apply(data):
	match self.type:
		Consumables.Damage:
			data.set_damageBonus(Attack.new(Attack.Slash, self.value))
		Consumables.Stamina:
			data.attributes.power.stamina += value
		Consumables.Defense:
			var defense = Defense.new(value, value, value)
			data.attributes.power.defense.add(defense)
			defense.queue_free()
		Consumables.HP:
			data.attributes.power.increaseHP(value)
		Consumables.Speed:
			data.attributes.power.speedBonus += value
	return

func takeBack(data):
	match self.type:
		Consumables.Damage:
			data.damageBonus.queue_free()
			data.set_damageBonus(null)
		Consumables.Stamina:
			data.attributes.power.stamina -= value
			# data.attributes.power.cur_stamina -= value
		Consumables.Defense:
			var defense = Defense.new(-value, -value, -value)
			data.attributes.power.defense.add(defense)
			defense.queue_free()
		Consumables.HP:
			pass
		Consumables.Speed:
			data.attributes.power.speedBonus -= value
	return
