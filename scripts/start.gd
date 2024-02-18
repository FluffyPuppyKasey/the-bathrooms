extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

func _ready():
	if FileAccess.file_exists("user://options.cfg") == false :
		config.set_value("options", "fullscreenMode", 0)
		config.set_value("options", "resolutionScale", 1.0)
		config.set_value("options", "lookSensitivity", 10.0)
		config.set_value("options", "fsr", false)
		config.set_value("options", "vhs_filter", true)
		config.set_value("options", "eyebleed", false)
		config.save("user://options.cfg")
	elif FileAccess.file_exists("user://options.cfg") == true:
		if config.get_value("options", "fullscreenMode") == 0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		elif config.get_value("options", "fullscreenMode") == 1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		elif config.get_value("options", "fullscreenMode") == 2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	config.load("user://options.cfg")

func _process(_delta):
	pass

func _on_credits_pressed():
	OS.shell_open("https://twitter.com/FluffyPupyKasey")

func _on_quit_game_pressed():
	get_tree().quit()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://levels/mainLevel.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_game_pressed():
	$".".visible = !$".".visible
	$"../../CanvasLayer5".visible = !$"../../CanvasLayer5".visible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_in_game_pressed():
	$HBoxContainer.visible = !$HBoxContainer.visible
	$VBoxContainer.visible = !$VBoxContainer.visible
	$Options.visible = !$Options.visible

func _on_options_pressed():
	$HBoxContainer.visible = !$HBoxContainer.visible
	$VBoxContainer.visible = !$VBoxContainer.visible
	$isThereALimit.visible = !$isThereALimit.visible
	$Options.visible = !$Options.visible

func _on_is_there_a_limit_toggled(button_pressed):
	get_node("MenuBG").isThereALimit = button_pressed
