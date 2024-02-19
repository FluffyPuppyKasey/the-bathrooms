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
	#_change_graphics_settings()
	if isThereALimit == true:
		pass
	elif isThereALimit == false:
		t = get_tree().create_timer(2.5)

func _process(delta):
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

#func _change_graphics_settings():
	#var config = ConfigFile.new()
	#var err = config.load("user://options.cfg")
	#for item in scene_list.size():
		#var mat = scene_list[item]
		#var oldMat = mat.get_surface_override_material(0).get_texture()
		#print(mat.get_surface_override_material(0).get_texture())
		#if config.get_value("options", "texture_quality") == 0:
			#if oldMat == "res://materials/ceiling_4K.tres" or "res://materials/ceiling_8K.tres":
				#mat.set_surface_override_material(0, preload("res://materials/ceiling.tres"))
				#print("Texture Quality is low. Ceiling texture set to 2K")
			#if oldMat == "res://materials/floor_4K.tres" or "res://materials/floor_8K.tres":
				#mat.set_surface_override_material(0, preload("res://materials/floor.tres"))
				#print("Texture Quality is low. Floor texture set to 2K")
			#if oldMat == "res://materials/walls_4K.tres" or "res://materials/walls_8K.tres":
				#mat.set_surface_override_material(0, preload("res://materials/walls.tres"))
				#print("Texture Quality is low. Wall texture set to 2K")
		#if config.get_value("options", "texture_quality") == 1:
			#if oldMat == "res://materials/ceiling_8K.tres" or "res://materials/ceiling.tres":
				#mat.set_surface_override_material(0, preload("res://materials/ceiling_4K.tres"))
				#print("Texture Quality is medium. Ceiling texture set to 4K")
			#if oldMat == "res://materials/floor_8K.tres" or "res://materials/floor.tres":
				#mat.set_surface_override_material(0, preload("res://materials/floor_4K.tres"))
				#print("Texture Quality is medium. Floor texture set to 4K")
			#if oldMat == "res://materials/walls.tres" or "res://materials/walls_8K.tres":
				#mat.set_surface_override_material(0, preload("res://materials/walls_4K.tres"))
				#print("Texture Quality is medium. Wall texture set to 4K")
		#if config.get_value("options", "texture_quality") == 1:
			#if oldMat == "res://materials/ceiling_4K.tres" or "res://materials/ceiling.tres":
				#mat.set_surface_override_material(0, preload("res://materials/ceiling_8K.tres"))
				#print("Texture Quality is high. Ceiling texture set to 8K")
			#if oldMat == "res://materials/floor_4K.tres" or "res://materials/floor.tres":
				#mat.set_surface_override_material(0, preload("res://materials/floor_8K.tres"))
				#print("Texture Quality is high. Floor texture set to 8K")
			#if oldMat == "res://materials/walls.tres" or "res://materials/walls_4K.tres":
				#mat.set_surface_override_material(0, preload("res://materials/walls_8K.tres"))
				#print("Texture Quality is high. Wall texture set to 8K")
