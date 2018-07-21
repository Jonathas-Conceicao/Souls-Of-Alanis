extends Area2D

signal finished_dialog

const SorcererNPCIdentifier = preload("SorcererNPCIdentifier.gd")

const npcName = "Priest"
const introText = "Greetings young traveler!"
const welcomeText = [
	" I am the priest of this little village, and I want to let you know you are very welcome.",
	"If you're an adventurer seeking the Orb of Wishes, know the forest that leads to the Castle can be treacherous.",
	"It is said that only a Knight pure of heart can find his or hers way through the castle."
]
const greetText = [
	"I've heard of overloded motherboard, but this is ridiculous"
]
const noHelpText = "The only help I can give you at this moment is to pray for the god above to guide your way."
const helpText = "I can help you, buddy"

const introSelection = "So, tell me, will you accept my aid?"
const options = ["Yes", "No"]

var dialogSet = false
var launchOptions = false

func _ready():
	$Balloon.enabled(false)
	self.set_options()
	$Sprite.play("Idle")
	return

func _on_player_interaction(host):
	$Sprite.play("Greet")
	self.set_dialog(host)
	$DialogBox.enabeled(true)
	if host.find_in_StartedQuests(self.get_uniqueID()) < 0:
		var aux = SorcererNPCIdentifier.new()
		host.add_child(aux)
		host.add_to_StartedQuests(aux)
	return "finished_dialog"

func set_dialog(host):
	if not self.dialogSet:
		$DialogBox.set_dialog(npcName, introText)
		$DialogBox.add_lines(greetText if host.find_in_StartedQuests(self.get_uniqueID()) >= 0 else welcomeText)
		if host.data.storedLevels() > 0:
			$DialogBox.add_dialog(helpText)
			self.launchOptions = true
		else:
			$DialogBox.add_dialog(noHelpText)
			self.launchOptions = false
			
	self.dialogSet = true
	return

func set_options():
	$SelectionBox.set_dialog(npcName, introSelection)
	$SelectionBox.add_items(options)
	return

func _on_DialogBox_finished_dialog(obj):
	obj.enabeled(false)
	$Sprite.play("Idle")
	if not launchOptions:
		emit_signal("finished_dialog", self)
	else:
		$SelectionBox.enabeled(true)
	return

func _on_SelectionBox_item_selected(obj, selected):
	if selected == 1: # "No" entry from Options
		obj.enabeled(false)
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

