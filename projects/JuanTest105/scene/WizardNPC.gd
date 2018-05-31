func _ready():
	pass

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
			
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_accept"):
			show_menu()
	
func show_menu():
	$Camera2D.zoom.x = 0.7
	$Camera2D.zoom.y = 0.7
	$NPCName.hide()
	$LabelMenu.show()
	$VBoxContainer.show()