extends Node

var level = preload("res://levels/mainLevel.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().get_root().add_child(level)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
