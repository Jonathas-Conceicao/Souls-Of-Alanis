# Bat - Foe
extends KinematicBody2D

enum STATE {
	IDLE,
	HITTED
}

var state = IDLE

const Foe = preload("res://script/classes/Foe.gd")
const Attack = preload("res://script/classes/Attack.gd")

var data

func _ready():
    state = IDLE
    data = Foe.new(Attack.Slash, Foe.Air)
    self.add_child(data)
    pass

func _physics_process(delta):
    pass

func _moves():
    pass

func _on_takeDamage(agressor, attack):
    state = HITTED
    var damage = data.takeAttack(attack)
    print ("Bat received ", damage, " from: ", agressor.get_name())
    pass
