extends "Cinematic.gd"

var introText = "This is Alanis"

var texts = [ "This is a text from the list",
		  "This one is also text from the list"]

func _ready():
	self.init(self.s, self.introText, self.texts)
	._ready()
	return
