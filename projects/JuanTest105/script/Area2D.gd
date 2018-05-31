extends Area2D

var skillPoints = 0

func _ready():
	$QuestionLabel.hide()
	pass

func _process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_accept"):
			show_menu()
	
func show_menu():
	$Camera2D.zoom.x = 0.7
	$Camera2D.zoom.y = 0.7
	$Name.hide()
	$QuestionLabel.show()
	

func _on_YesButton_pressed():
	$QuestionLabel.hide()
	$ItemList.show()
	
func _on_NoButton_pressed():
	$QuestionLabel.hide()
	$Name.show()


func _on_YesButtonUP_pressed():
	
	if skillPoints > 0:
		$QuestionLabel.hide()
		$ItemList.hide()
		$SucessPointsLabel.show()
		$SucessPointsLabel/Timer2.start()
		
	else:
		$QuestionLabel.hide()
		$ItemList.hide()
		$InsuPointsLabel.show()
		$InsuPointsLabel/Timer.start()
	
	$QuestionLabel.hide()
	$ItemList.hide()


func _on_NoButtonUP_pressed():	
	$QuestionLabel.hide()
	$ItemList.hide()


func _on_Timer_timeout():
	$InsuPointsLabel.hide()
	$SucessPointsLabel.hide()
	$Name.show()
