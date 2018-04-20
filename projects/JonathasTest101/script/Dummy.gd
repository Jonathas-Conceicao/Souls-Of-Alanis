extends KinematicBody2D

enum STATE {
	IDLE,
	HITED
}

var state = IDLE

var speechs = [	"Hey! You there! Come hit me!",
				"I dare you to trying killing me",
				"Come at me, bro!"]

func _ready():
	state = IDLE
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

func _on_meele_hit(hitter):
	state = HITED
	print("Hitted by:", hitter.get_name())