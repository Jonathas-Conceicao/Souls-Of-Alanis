extends "res://script/Classes/Unique.gd"

var STATE_CHEST = "CLOSED"

const new_item = preload("res://Items/predefined/StarterSword.gd")

var ChestID = preload("res://scene/utils/ChestID.gd")

func show_popUp():
	#$Label.show()
	return

func hide_popUp():
	#$Label.hide()
	return

func _on_player_interaction(host):
	if STATE_CHEST == "CLOSED":
		$Open_se.play()
		$AnimatedSprite.play("opened")
		self.hide_popUp()
		STATE_CHEST = "OPENED"
		var ni = new_item.new()
		var ib = ni.gen_ItemBody()
		add_child(ib)
		ib.spawn()
		host.add_to_StartedQuests(ChestID.new())
	return

func _on_Open_chest_area_body_entered(body):
	if body.name == "Player" && STATE_CHEST == "CLOSED":
		self.show_popUp()
	return

func _on_Open_chest_area_body_exited(body):
	self.hide_popUp()

##ADDED
# FOR CHESTS
# enabled = false <=> open chest
# enabled = true <=> closed chest
func enabled(t = true):
	if !t:
		STATE_CHEST = "OPENED"
		$AnimatedSprite.play("opened")
	else:
		STATE_CHEST = "CLOSED"
		$AnimatedSprite.play("closed")
	return null# self

# define by @Jonathas on #1489c0194c6679ffb9a2fd2535a71261e958245f
func get_uniqueID():
	var aux = ChestID.new()
	var auxID = aux.get_uniqueID()
	aux.queue_free()
	return auxID


func _on_fchallenge_1_ChallengeFailed(body):
	if body.get_name() == "Player":
		$ChallengeFailedSign.show()
