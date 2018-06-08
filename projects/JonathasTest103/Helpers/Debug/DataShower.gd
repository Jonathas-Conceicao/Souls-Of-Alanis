extends Panel

onready var VAR_CONT = $MainContainer/ListContainer/VariableContainer
onready var DSC_CONT = $MainContainer/ListContainer/DescriptionContatiner

onready var VAR_LABEL   = $VAR_CONT/Variable
onready var DESC_LABEL  = $DSC_CONT/Description
onready var ARRW_LABEL  = $MainContainer/ListContainer/HBoxContainer2/Arrow
onready var TITLE_LABEL = $MainContainer/TitleContainer/Title
var host

var varList  = []
var descList = []

func _ready():
	self.host = self.get_parent()
	setTitle(self.host)

func setTitle(host):
	self.host = host
	var text = host.get_name()
	TITLE_LABEL.text = text + " Data"

func _on_Target_StateChanged(state):
	self.cleanLabels()
	if host.has_method("getData"):
		var list = host.getData()
		addLabels(list)

func addLabels(list):
	for item in list:
		var label = Label.new()
		label.text = item[0]
		varList.append(label)
		VAR_CONT.add_child(label)
		label = Label.new()
		label.text = str(item[1])
		descList.append(label)
		DSC_CONT.add_child(label)

func cleanLabels():
	for item in varList:
		item.queue_free()
	for item in descList:
		item.queue_free()
	varList  = []
	descList = []