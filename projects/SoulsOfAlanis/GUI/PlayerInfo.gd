extends "MenuItem.gd"

export (bool) var focused = false

var selected = 0
var attributes
var attributesSize

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("finished_interaction",  self, -1, 0)
	return

func test_ready():
	self.focused(false)
	self.init([3, 1, 3, 1],
			  [75, 75, 10, 1,
			   45, 50, 65, 80])
	return

func _ready():
	$Animation.play("Intro")
	self.updateAtributes()
	self.focused(self.focused)
	self.enabled(self.focused)

	# self.test_ready()
	return

func enabled(b):
	$Background.visible = b
	set_process_input(b)
	return

func updateAtributes():
	self.attributes = $Background/AttributesContainer.get_children()
	self.attributesSize = self.attributes.size()
	return

func init(attributes, power):
	$Background/AttributesContainer/Vitality.set_value(attributes[0])
	$Background/AttributesContainer/Strength.set_value(attributes[1])
	$Background/AttributesContainer/Agility.set_value(attributes[2])
	$Background/AttributesContainer/Wisdom.set_value(attributes[3])
	
	$Background/PowersContainer/Left/HP.set_value(power[0])
	$Background/PowersContainer/Left/Stamina.set_value(power[1])
	$Background/PowersContainer/Left/Weight.set_value(power[2])
	$Background/PowersContainer/Left/XP_Gain.set_value(power[3])
	
	$Background/PowersContainer/Right/Attack.set_value(power[4])
	$Background/PowersContainer/Right/Slash.set_value(power[5])
	$Background/PowersContainer/Right/Impact.set_value(power[6])
	$Background/PowersContainer/Right/Thrust.set_value(power[7])
	return

func focused(b):
	self.focused = b
	for att in self.attributes:
		att.focused(b)
		att.selected(false)
	if b:
		attributes[self.selected].selected(true)
	return

func select(who):
	self.attributes[self.selected].selected(false)
	self.selected = who
	self.attributes[self.selected].selected(true)
	return

func _on_Attribute_finished_interaction(value):
	match value:
		-1:
			emit_signal("finished_interaction", self, -1, -1)
		0:
			self.select((self.selected - 1 + self.attributesSize) % self.attributesSize)
		1:
			self.select((self.selected + 1) % self.attributesSize)
		_:
			emit_signal("finished_interaction", self, self.selected, 1)
	return

func _on_PlayerInfo_finished_interaction(obj, who, val):
	if who == -1:
		print("PlayerInfo should close now")
	else:
		print(self.attributes[who].get_name(), " incremented by:", val)
	return

func _on_Close_pressed():
	emit_signal("finished_interaction",  self, -1, 0)
	return
