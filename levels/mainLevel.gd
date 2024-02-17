extends Node3D

func _ready():
	pass

func _process(delta):
	disable_vhs_filter()

func disable_vhs_filter():
	var config = ConfigFile.new()
	var err = config.load("user://options.cfg")
	if config.get_value("options", "vhs_filter") == true:
		$Player/Pivot/Camera/CanvasLayer3.visible = true
		$Player/Pivot/Camera/CanvasLayer.visible = true
		$Player/Pivot/Camera/CanvasLayer4.visible = true
	elif config.get_value("options", "vhs_filter") == false:
		$Player/Pivot/Camera/CanvasLayer3.visible = false
		$Player/Pivot/Camera/CanvasLayer.visible = false
		$Player/Pivot/Camera/CanvasLayer4.visible = false
