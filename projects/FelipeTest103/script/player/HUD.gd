extends CanvasLayer

func _ready():
	pass

func setHP(hp):
	$HealthBar.set_value(hp)

func setStamina(st):
	$StaminaBar.set_value(st)