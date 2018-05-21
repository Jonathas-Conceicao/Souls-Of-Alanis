tool
extends Button

func _ready():
  pass

func _enter_tree():
    connect("pressed", self, "clicked")

func clicked():
    print("You clicked me!")
