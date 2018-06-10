extends CanvasLayer

func _on_Target_DataUpdated(host):
	var data = host.data
	var hpMax = data.getMaxHP()
	var hpCur = data.getHP()
	var hpP = calcPercentage(hpMax, hpCur)
	var stMax = data.getMaxStamina()
	var stCur = data.getStamina()
	var staminaP = calcPercentage(stMax, stCur)
	self.setHP(hpP)
	self.setStamina(staminaP)
	return

func calcPercentage(h, l):
	return (l*100)/h

func setHP(hp):
	$HealthBar.set_value(hp)
	return

func setStamina(st):
	$StaminaBar.set_value(st)
	return
