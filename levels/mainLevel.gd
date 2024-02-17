extends Node3D

var t

func _ready():
	t = get_tree().create_timer(.16667)
	pass

func _process(delta):
	disable_vhs_filter()
	if t.time_left <= 0.0:
		t = get_tree().create_timer(.16667)
		_set_viewport_mat($Monitor, $SubViewport)

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

func _set_viewport_mat(_display_mesh : MeshInstance3D, _sub_viewport : SubViewport, _surface_id : int = 1):
	var _mat : StandardMaterial3D = StandardMaterial3D.new()
	_mat.emission_enabled = true
	_mat.emission_energy_multiplier = 1.0
	_mat.metallic_specular = 1.0
	_mat.roughness = 0
	_mat.emission_texture = _sub_viewport.get_texture()
	_display_mesh.set_surface_override_material(_surface_id, _mat)
