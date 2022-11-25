extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	if 	get_tree().get_current_scene().get_name() == "Menu":
		$Options.hide()
	elif get_tree().get_current_scene().get_name() == "Player":
		$Menu/Options.hide()
	if config.get_value("options", "fullscreenMode") == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif config.get_value("options", "fullscreenMode") == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif config.get_value("options", "fullscreenMode") == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_credits_pressed():
	OS.shell_open("https://twitter.com/FluffyPupyKasey")

func _on_quit_game_pressed():
	get_tree().quit()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://levels/mainLevel.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_game_pressed():
	$Menu.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_in_game_pressed():
	#$/Player/Menu/Options.show()
	$Menu/Options/Label.visible = !$Menu/Options/Label.visible
	$Menu/Options/VBoxContainer.visible = !$Menu/Options/VBoxContainer.visible
	
func _on_options_pressed():
	$HBoxContainer.hide()
	$VBoxContainer.hide()
	$Options.show()
