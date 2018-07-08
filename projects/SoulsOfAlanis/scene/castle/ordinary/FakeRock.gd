extends StaticBody2D #Area2D

var is_cracked = false

func _ready():
  return

func _on_takeDamage(agressor, attack):
  if (agressor.get_name() == "Player") && (!is_cracked):
    # Change tile to broken rock
    # Drop some random potion
    is_cracked = true
    print("The rock is now craked!")
  return