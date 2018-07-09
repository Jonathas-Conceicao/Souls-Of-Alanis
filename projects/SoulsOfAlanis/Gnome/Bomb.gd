extends Area2D

const Attack = preload("res://script/Classes/Attack.gd")
const Foe = preload ("res://script/Classes/Foe.gd")

const SPEED = 250
var motion = Vector2(1, 0)
var damage = 45
var atck = null
var data = null

# Inicialização
func _ready(direction):
	data = Foe.new()
	self.add_child(data)
	atck = data.genAttack()
	print(atck)
	motion.x = direction

# Movimenta a bala
func _process(delta):
	translate(motion * SPEED * delta)
	pass

func _on_Bomb_body_entered(body):
	if body.has_method("_on_takeDamage"):
		body._on_takeDamage(self, atck)
	pass # replace with function body
