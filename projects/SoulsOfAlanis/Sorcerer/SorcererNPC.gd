extends Area2D

signal finished_dialog

const SorcererNPCIdentifier = preload("SorcererNPCIdentifier.gd")

const npcName = "Priest"
const introText = "Greetings young traveler!"
const welcomeText = [
	"I am the priest of this little village, and I want to let you know you are very welcome.",
	"If you're an adventurer seeking the Orb of Wishes, know the forest that leads to the Castle can be treacherous.",
	"It is said that only a Knight pure of heart can find his or hers way through the castle."
]
const greetText = [
	"I've heard of overloded motherboard, but this is ridiculous"
]

const introNoHelp = "The only help I can give you at this moment is to pray for the god above to guide your way."
const noHelpText  = []
const introHelp   = "I can help you, buddy."
const canHelpText = ["So, tell me, will you accept my aid?"]
const options = ["Yes", "No"]

const introPostHelp = "Estás mais forte, arrombadx"
const postHelpText = []
const introNoPostHelp = "Vai lá morrer então, trouxa"
const postNoHelpText = []

var host

func _ready():
	$Balloon.enabled(false)
	self.set_dialog($WelcomeBox, introText, welcomeText)
	self.set_dialog($GreetBox, introText, greetText)
	self.set_dialog($NoHelpBox, introNoHelp, noHelpText)
	self.set_options($CanHelpBox, introHelp, canHelpText, options)
	self.set_dialog($PostHelp, introPostHelp, postHelpText)
	self.set_dialog($PostNoHelp, introNoPostHelp, postNoHelpText)
	$Sprite.play("Idle")
	return

func _on_player_interaction(host):
	self.host = host
	$Sprite.play("Greet")
	
	if host.find_in_StartedQuests(self.get_uniqueID()) < 0:
		var aux = SorcererNPCIdentifier.new()
		host.add_child(aux)
		host.add_to_StartedQuests(aux)
		$WelcomeBox.enabled(true)
	else:
		$GreetBox.enabled(true)
	var data = host.get_data_for_display()
	$PlayerInfo.init(data[0], data[1])
	return "finished_dialog"

func set_dialog(box, intro, texts):
	box.set_dialog(npcName, intro)
	box.add_lines(texts)
	return

func set_options(box, intro, texts, options):
	box.set_dialog(npcName, intro)
	box.add_lines(texts)
	box.add_items(options)
	return

func dialogSwap(fromBox, toBox = null):
	fromBox.enabled(false)
	if fromBox.has_method("focused"): fromBox.focused(false)
	$Sprite.play("Greet")
	if toBox != null:
		toBox.enabled(true)
		if toBox.has_method("focused"): toBox.focused(true)
	else:
		emit_signal("finished_dialog", self)
	return

func _on_Self_body_entered(body):
	if body.get_name() == "Player":
		$Balloon.enabled(true)
	return

func _on_Self_body_exited(body):
	if body.get_name() == "Player":
		$Balloon.enabled(false)
	return

func enabled(t): # Should always be visible on prelude
	return

func get_uniqueID():
	var aux = SorcererNPCIdentifier.new()
	var auxID = aux.get_uniqueID()
	aux.queue_free()
	return auxID

func _on_First_finished_dialog(box):
	self.dialogSwap(box, $CanHelpBox if host.data.storedLevels() >= 1 else $NoHelpBox)
	return

func _on_NoHelpBox_finished_dialog(box):
	self.dialogSwap(box, null)
	return

func _on_CanHelpBox_item_selected(box, selected):
	self.dialogSwap(box, null if selected == 1 else $PlayerInfo)
	return

func _on_PlayerInfo_finished_interaction(obj, who, val):
	if who == -1:
		self.dialogSwap(obj, $PostHelp)
	else:
		host.data.levelUp(who)
		var data = host.get_data_for_display()
		$PlayerInfo.init(data[0], data[1])
		if host.data.storedLevels() < 1:
			obj.focused(false)
	return

func _on_PostHelp_finished_dialog(box):
	self.dialogSwap(box, null)

func _on_PostNoHelp_finished_dialog(box):
	self.dialogSwap(box, null)
