extends KinematicBody2D

enum STATE {
	IDLE,
	HITED
}

var state = IDLE

var speechs = [	"Hey! You there! Come hit me!",
				"I dare you to trying killing me",
				"Come at me, bro!"]

const Foe    = preload("res://script/Classes/Foe.gd")
const Attack = preload("res://script/Classes/Attack.gd")
const DamageShower = preload("res://HUD/Damage.tscn")

signal DataUpdated
var data

func _ready():
	state = IDLE
	data = Foe.new(Attack.Slash)
	self.add_child(data)
	return

func _physics_process(delta):
	emit_signal("DataUpdated", self)
	return

func _on_takeDamage(agressor, attack):
	state = HITED
	var damage = data.takeAttack(attack)
	var damageDisplay = DamageShower.instance()
	damageDisplay.init(self,
					   $DamageSpot.get_position(),
					   Vector2(1.5, 1.5),
					   damage)
	self.add_child(damageDisplay) # The label frees it self when finished
	print("Dummy recived ", damage, " from: ", agressor.get_name())
	return

func getData():
	var data = []
	data.append(["HP", self.data.getHP()])
	data.append(["Stamina", self.data.getStamina()])
	return data

func _on_Hand_body_entered(body):
	if body != self && body.has_method("_on_takeDamage"):
		var attack = data.genAttack()
		body._on_takeDamage(self, attack)
	return
