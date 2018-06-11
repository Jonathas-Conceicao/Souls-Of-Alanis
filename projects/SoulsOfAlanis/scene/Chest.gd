extends Area2D

var itemID

func _physics_process(delta):
	
	var bodies = get_overlapping_bodies()
	var item
	
	for body in bodies:
		
		if body.name == "Player" && Input.is_action_pressed("ui_attack"):
			$Closed.hide()
			$Opened.show()
			
			randomize()
			itemID = randi()%10
			
			item = get_item(itemID)
			$Potion/Item.show()
			
func get_item(itemID):
	return 1