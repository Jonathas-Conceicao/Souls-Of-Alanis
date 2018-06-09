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

var data

func _ready():
	state = IDLE
	data = Foe.new(Attack.Slash)
	self.add_child(data)
	$Label.hide()
	$WaitTimer.start()

func _physics_process(delta):
	pass

func taunt():
	$Label.text = speechs[randi() % speechs.size()]
	$Label.show()

func _on_WaitTimer_timeout():
	taunt()
	$HideTimer.start()

func _on_HideTimer_timeout():
	$Label.hide()
	$WaitTimer.start()

func _on_takeDamage(agressor, attack):
	state = HITED
	var damage = data.takeAttack(attack)
	var damegeDisplay = DamageShower.instance()
	damegeDisplay.set_position($DamegeSpot.get_position())
	damegeDisplay.setValue(damage)
	damegeDisplay.set_scale(self.scale)
	self.add_child(damegeDisplay) # The label frees it self when finished
	print("Dummy recived ", damage, " from: ", agressor.get_name())
	

