extends Area2D

var STATE_CHEST = "CLOSED"

func show_popUp():
	$Label.show()
	return

func hide_popUp():
	$Label.hide()
	return

func _on_player_interaction(host):
	if STATE_CHEST == "CLOSED":
		$Open_se.play()
		$AnimatedSprite.play("opened")
		self.hide_popUp()
		STATE_CHEST = "OPENED"
	return

func _on_Open_chest_area_body_entered(body):
	if body.name == "Player" && STATE_CHEST == "CLOSED":
		self.show_popUp()
	return

func _on_Open_chest_area_body_exited(body):
	self.hide_popUp()
