extends Node

var SceneOptions = "res://assets/UI/Menu/Options.tscn"
var SceneMenu = "res://assets/UI/Menu/Main_menu.tscn"
var Options = null
var Menu = null

func _enter_tree():
	var Base = Control.new()
	Base.set_name("Base")
	if get_tree().get_root().has_node("world/UI_in_game"):
		UIManager.RegisterBaseUI("/root/world/UI_in_game")
	pass
	

func _input(event):
	if event.is_action_pressed("ui_menu_options") and get_tree().get_root().has_node("world/ChatUI"):
		MainPanel()

func MainPanel():
	if Menu:
		Menu.queue_free()
		Menu = null
		Input.set_mouse_mode(options.get("_state_", "menu_options_mm", Input.MOUSE_MODE_VISIBLE))
	else:
		Menu = ResourceLoader.load(SceneMenu).instance()
		Menu.name = "Menu"
		get_node("/root/world/UI_in_game").add_child(Menu)
		UIManager.SetCurrentUI(get_node("/root/world/UI_in_game/Menu"))
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func OptionsPanel():
		if Options:
			options.set("_state_", Options.get_tab_index(), "menu_options_tab")
			Options.queue_free()
			Options = null
			options.save()
			Input.set_mouse_mode(options.get("_state_", "menu_options_mm", Input.MOUSE_MODE_VISIBLE))
		else:
			Options = ResourceLoader.load(SceneOptions).instance()
			Options.signal_close = true
			Options.connect("close", self, "OptionsPanel")
			Options.set_tab_index(options.get("_state_", "menu_options_tab", 1))
			get_tree().get_root().add_child(Options)
			options.set("_state_", Input.get_mouse_mode(), "menu_options_mm")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
