extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

var mouseSens = config.get_value("options", "lookSensitivity")

# Called when the node enters the scene tree for the first time.
func _ready():
	if err != OK:
		return
	elif err == OK:
		$VBoxContainer/Resolution/ResScaleLabel.text = str(config.get_value("options", "resolutionScale"))
		$VBoxContainer/Resolution/ResSlider.value = config.get_value("options", "resolutionScale")
		$VBoxContainer/Supersampling/SSCheckBox.button_pressed = config.get_value("options", "supersampling")
		$VBoxContainer/MouseSensitivity/SensSlider.value = config.get_value("options", "lookSensitivity")
		$VBoxContainer/MouseSensitivity/Label2.text = str(config.get_value("options", "lookSensitivity"))
		if config.get_value("options", "fullscreenMode") == 0:
			$VBoxContainer/Fullscreen/OptionButton.select(0)
		elif config.get_value("options", "fullscreenMode") == 1:
			$VBoxContainer/Fullscreen/OptionButton.select(1)
		elif config.get_value("options", "fullscreenMode") == 2:
			$VBoxContainer/Fullscreen/OptionButton.select(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_option_button_item_selected(index):
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		config.set_value("options", "fullscreenMode", 0)
		config.save("user://options.cfg")
	elif index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		config.set_value("options", "fullscreenMode", 1)
		config.save("user://options.cfg")
	elif index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		config.set_value("options", "fullscreenMode", 2)
		config.save("user://options.cfg")


func _on_ss_check_box_toggled(button_pressed):
	if button_pressed == true:
		$VBoxContainer/Resolution/ResSlider.max_value = 200
		$VBoxContainer/Resolution/ResSlider.min_value = 100
		config.set_value("options", "supersampling", true)
		config.save("user://options.cfg")
	elif button_pressed == false:
		$VBoxContainer/Resolution/ResSlider.max_value = 100
		$VBoxContainer/Resolution/ResSlider.min_value = 25
		config.set_value("options", "supersampling", false)
		config.save("user://options.cfg")

func _on_res_slider_value_changed(value):
	$VBoxContainer/Resolution/ResScaleLabel.text = str(value) + "%"
	config.set_value("options", "resolutionScale", $VBoxContainer/Resolution/ResSlider.value)
	config.save("user://options.cfg")

func _on_back_to_menu_pressed():
	if 	get_tree().get_current_scene().get_name() == "Menu":
		$/root/Menu/HBoxContainer.visible = !$/root/Menu/HBoxContainer.visible
		$/root/Menu/VBoxContainer.visible = !$/root/Menu/VBoxContainer.visible
	elif get_tree().get_current_scene().get_name() == "Player":
		$/root/PauseMenu/HBoxContainer.visible = !$/root/PauseMenu/HBoxContainer.visible
		$/root/PauseMenu/VBoxContainer.visible = !$/root/PauseMenu/VBoxContainer.visible
	$Label.hide()
	$VBoxContainer.hide()

func _on_sens_slider_value_changed(value):
	config.set_value("options", "lookSensitivity", value)
	$VBoxContainer/MouseSensitivity/Label2.text = str(value)
	config.save("user://options.cfg")


func _on_res_slider_changed():
	pass
