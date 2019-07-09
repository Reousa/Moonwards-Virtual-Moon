extends Control
var scripts = {
	Updater = preload("res://update/scripts/Updater.gd")
}
var Updater
func _ready():
	Updater = scripts.Updater.new()
	Updater.connect("receive_update_message", self, "AddLogMessage")

func AddLogMessage(var text):
	if not self.visible:
		self.visible = true
	$VBoxContainer/VBoxContainer/RichTextLabel.text += text + "\n"

func SwitchScene():
	get_tree().change_scene(ProjectSettings.get_setting("application/run/main_scene"))

func RunUpdateServer():
	$VBoxContainer/VBoxContainer/State.text = "Server"
	Updater.RunUpdateServer()

func RunUpdateClient():
	$VBoxContainer/VBoxContainer/State.text = "Client"
	Updater.RunUpdateClient()