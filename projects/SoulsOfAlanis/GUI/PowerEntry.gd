extends TextureRect

export (int) var Value = 10
export (String) var Name = "Vitality"

func _ready():
	self.update()
	return

func set_value(v):
	self.Value = v
	self.update()
	return

func update():
	$NameContainer/Name.set_text(self.Name)
	$ValueContainer/Value.set_text(str(self.Value))