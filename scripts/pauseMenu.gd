extends Node

func _ready():
	pass

func _process(_delta):
	pass

func _on_quit_game_pressed():
	get_tree().quit()

func _on_resume_game_pressed():
	get_parent().visible = !get_parent().visible
	$"../../CanvasLayer5".visible = !$"../../CanvasLayer5".visible
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_options_pressed():
	$VBoxContainer.visible = !$VBoxContainer.visible
	$HBoxContainer.visible = !$HBoxContainer.visible
	$Options.visible = !$Options.visible

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_cancel") and get_tree().paused == true:
		#_on_resume_game_pressed()
