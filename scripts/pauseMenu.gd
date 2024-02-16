extends Node

func _ready():
	pass

func _process(_delta):
	pass

func _on_quit_game_pressed():
	get_tree().quit()

func _on_resume_game_pressed():
	$".".visible = !$".".visible
	$"../../CanvasLayer5".visible = !$"../../CanvasLayer5".visible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_pressed():
	$HBoxContainer.visible = !$HBoxContainer.visible
	$VBoxContainer.visible = !$VBoxContainer.visible
	$Options.visible = !$Options.visible
