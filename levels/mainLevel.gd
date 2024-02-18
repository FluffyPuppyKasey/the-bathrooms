extends Node3D

var config = ConfigFile.new()
var err = config.load("user://options.cfg")
var scene_list=[]

var t

func _enter_tree():
	get_tree().node_added.connect(self.node_list)

func _ready():
	_set_eyebleed(0)
	_set_eyebleed(1)
	_set_eyebleed(2)
	_set_eyebleed(3)
	var config = ConfigFile.new()
	var err = config.load("user://options.cfg")
	get_tree().node_added.disconnect(self.node_list)
	t = get_tree().create_timer(.16667)
	_get_camera_view($Monitor, 1)
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

func _get_camera_view(_display_mesh : MeshInstance3D, _surface_id : int):
	var _mat : StandardMaterial3D = StandardMaterial3D.new()
	_mat.emission_enabled = true
	_mat.emission_energy_multiplier = 8.0
	_mat.roughness = 0
	_mat.emission_texture = $Player/Pivot/Camera.get_viewport().get_texture()
	#$SubViewport/Display/DisplayTexture.material = _mat
	
	_display_mesh.set_surface_override_material(_surface_id, _mat)

func _set_eyebleed(_surface_id : int):
	var config = ConfigFile.new()
	var err = config.load("user://options.cfg")
	if config.get_value("options", "eyebleed") == true:
		for item in scene_list.size():
			var mesh = scene_list[item]
			var _mat : ShaderMaterial = ShaderMaterial.new()
			_mat.set_shader(preload("res://shaders/eyebleed.gdshader"))
			mesh.set_surface_override_material(_surface_id, _mat)
	elif config.get_value("options", "eyebleed") == false:
		pass

func node_list(node):
	if node.is_class("MeshInstance3D"):
		scene_list.append(node)
