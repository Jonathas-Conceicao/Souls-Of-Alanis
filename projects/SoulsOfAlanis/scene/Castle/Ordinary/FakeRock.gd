extends StaticBody2D

var is_cracked = false

func _ready():
  return

func _on_takeDamage(agressor, attack):
  if (agressor.get_name() == "Player") && (!is_cracked):
    print("The rock is now craked!")
    is_cracked = true
  return
  
    
    