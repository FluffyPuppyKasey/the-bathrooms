extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")
var scene_list=[]

var ToiletInstance = preload("res://scriptDependencies/ToiletInst.tscn")
var t
var isThereALimit = false

func _ready():
	_set_eyebleed(0)
	_set_eyebleed(1)
	_set_eyebleed(2)
	_set_eyebleed(3)
	print(scene_list)
	if isThereALimit == true:
		pass
	elif isThereALimit == false:
		t = get_tree().create_timer(2.5)

func _process(delta):
	_set_eyebleed(0)
	_set_eyebleed(1)
	_set_eyebleed(2)
	_set_eyebleed(3)
	if t.time_left <= 0.0:
		if isThereALimit == true:
			add_child(ToiletInstance.instantiate())
			_set_eyebleed(0)
			_set_eyebleed(1)
			_set_eyebleed(2)
			_set_eyebleed(3)
		elif isThereALimit == false:
			t = get_tree().create_timer(2.5)
			add_child(ToiletInstance.instantiate())
			_set_eyebleed(0)
			_set_eyebleed(1)
			_set_eyebleed(2)
			_set_eyebleed(3)

func _enter_tree():
	get_tree().node_added.connect(self.node_list)

func _set_eyebleed(_surface_id: int):
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
