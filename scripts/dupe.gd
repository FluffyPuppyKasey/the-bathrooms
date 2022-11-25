extends Node

var ToiletInstance = preload("res://scriptDependencies/ToiletInst.tscn")
var t

# Called when the node enters the scene tree for the first time.
func _ready():
	t = await(get_tree().create_timer(2.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if t.time_left <= 0.0:
		t = await(get_tree().create_timer(2.5))
		var toiletInstance2 = ToiletInstance.instantiate()
		add_child(toiletInstance2)
