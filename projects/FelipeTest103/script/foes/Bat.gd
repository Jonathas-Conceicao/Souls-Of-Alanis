# Bat - Foe
extends KinematicBody2D

const Foe = preload("res://script/classes/Foe.gd")
const Attack = preload("res://script/classes/Attack.gd")
#const Weapon = preload("res://script/classes/Weapon.gd")

const MAXSPEED = 350

enum MOVEMENTS  {IDLE, PATROL, SENTINEL}
enum ATTACKS    {BITE}
enum DIRECTIONS {UP, DOWN, LEFT, RIGHT}

var speed = 350

var direction
var movement
var attack
var velocity = Vector2()

func _ready():
    data = Foe.new(Attack.Slash, Foe.Air)
    self.add_child(data)
    pass

func _physics_process(delta):
    update_velocity()
    update_animation()
    pass


func _on_takeDamage(agressor, attack):
    var damage = data.takeAttack(attack)
    print ("Bat received ", damage, " from: ", agressor.get_name())
    pass
