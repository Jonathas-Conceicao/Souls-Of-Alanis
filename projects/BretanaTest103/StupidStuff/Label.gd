extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var accum = 0
var stop = false

func _ready():
  pass
  
func _process(delta):
  accum += delta;
  if !stop:
    text = str(accum)
