extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_credits_pressed():
	OS.shell_open("https://twitter.com/FluffyPupyKasey")


func _on_quit_game_pressed():
	get_tree().quit()


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://mainLevel.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_resume_game_pressed():
	get_tree().get_root().get_node("Menu")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_in_game_pressed():
	get_tree().change_scene_to_file("res://OptionsMenuInGame.tscn")
