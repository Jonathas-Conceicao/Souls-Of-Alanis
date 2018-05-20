# this file is a class, name "MainScene" (filename)
extends Panel
# this extends the node where it is attached, 
# i.e., the Panel type on node
# therefore this scricp have all the Panel function,
# where we should add the functionalities wanted

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# THIS is the constructor
func _init():
  pass

# execute when this node and all its children enter the scene
func _ready():
  get_node("Button").connect("pressed", self, "on_Button_pressed")
  pass

func on_Button_pressed(): 
  get_node("Label").text += " time passed!"
  get_node("Label").stop = !get_node("Label").stop
  pass

#func _process(delta):
#  # Called every frame. Delta is time since last frame.
#  # Update game logic here.
#  pass
