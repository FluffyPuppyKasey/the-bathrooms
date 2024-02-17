extends Node

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

var ToiletInstance = preload("res://scriptDependencies/ToiletInst.tscn")
var t
var isThereALimit = false

func _ready():
	if isThereALimit == true:
		pass
	elif isThereALimit == false:
		t = get_tree().create_timer(2.5)

func _process(_delta):
	if t.time_left <= 0.0:
		if isThereALimit == true:
			add_child(ToiletInstance.instantiate())
		elif isThereALimit == false:
			
			add_child(ToiletInstance.instantiate())
