extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Options/OptionsMenu.hide()
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
	$Options/OptionsMenu.hide()
	$".".visible = !$".".visible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_in_game_pressed():
	$".".visible = !$".".visible
	$Options/OptionsMenu.show()
	
func _on_options_pressed():
	$HBoxContainer.visible = !$HBoxContainer.visible
	$VBoxContainer.visible = !$VBoxContainer.visible
	$Options/OptionsMenu.show()
