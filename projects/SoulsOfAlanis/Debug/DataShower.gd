extends Panel

onready var VAR_CONT = $MainContainer/ListContainer/VariableContainer
onready var DSC_CONT = $MainContainer/ListContainer/DescriptionContatiner
onready var ARW_CONT = $MainContainer/ListContainer/ArrowContainer

onready var VAR_LABEL   = $MainContainer/ListContainer/VariableContainer/Variable
onready var DESC_LABEL  = $MainContainer/ListContainer/DescriptionContatiner/Description
onready var ARRW_LABEL  = $MainContainer/ListContainer/ArrowContainer/Arrow
onready var TITLE_LABEL = $MainContainer/TitleContainer/Title

var host

var varList  = []
var descList = []
var arrwList = []

func _ready():
	self.host = self.get_parent()
	setTitle(self.host)
	return

func setTitle(host):
	self.host = host
	var text = host.get_name()
	TITLE_LABEL.text = text + "'s Data"

func _on_Target_DataUpdated(state):
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
		label = Label.new()
		label.text = "->"
		arrwList.append(label)
		ARW_CONT.add_child(label)

func cleanLabels():
	for i in range(0, arrwList.size()):
		varList[i].queue_free()
		descList[i].queue_free()
		arrwList[i].queue_free()
	varList  = []
	descList = []
	arrwList = []
