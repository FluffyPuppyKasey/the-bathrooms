extends Node

var ToiletInstance = preload("res://scriptDependencies/ToiletInst.tscn")
var t
var isThereALimit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if isThereALimit == true:
		pass
	elif isThereALimit == false:
		t = await(get_tree().create_timer(2.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if t.time_left <= 0.0:
		if isThereALimit == true:
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
			add_child(ToiletInstance.instantiate())
		elif isThereALimit == false:
			t = await(get_tree().create_timer(2.5))
			add_child(ToiletInstance.instantiate())
