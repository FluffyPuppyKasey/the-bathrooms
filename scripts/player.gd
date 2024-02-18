extends CharacterBody3D

var config = ConfigFile.new()
var err = config.load("user://options.cfg")

var mouseSens = config.get_value("options", "lookSensitivity") / 2000

var SPEED = 5
var SPRINTSPEED = SPEED * 2
const JUMP_VELOCITY = 2.5
const SLIDE_VELOCITY = 5

func _ready():
	$Pivot/Camera/CanvasLayer2.visible = !$Pivot/Camera/CanvasLayer2.visible

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Pivot
@onready var camera := $Pivot/Camera

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Pivot/Camera/CanvasLayer2.visible = !$Pivot/Camera/CanvasLayer2.visible
		$Pivot/Camera/CanvasLayer5.visible = !$Pivot/Camera/CanvasLayer5.visible
	if $Pivot/Camera/CanvasLayer2.visible == false and event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and !event.is_action_pressed("ui_cancel"):
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * mouseSens)
			camera.rotate_x(-event.relative.y * mouseSens)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if Input.is_action_pressed("sprint"):
			velocity.x = direction.x * SPRINTSPEED
			velocity.z = direction.z * SPRINTSPEED
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if Input.is_action_pressed("joyLookRight"):
		neck.rotate_y(Input.get_action_strength("joyLookRight") * -(mouseSens * 10))

	if Input.is_action_pressed("joyLookLeft"):
		neck.rotate_y(Input.get_action_strength("joyLookLeft") * (mouseSens * 10))

	if Input.is_action_pressed("joyLookUp"):
		camera.rotation.x -= Input.get_action_strength("joyLookUp") * -(mouseSens * 10)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

	if Input.is_action_pressed("joyLookDown"):
		camera.rotation.x -= Input.get_action_strength("joyLookDown") * (mouseSens * 10)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

	if Input.is_action_just_pressed("flashlight"):
		$SpotLight3D.visible = !$SpotLight3D.visible
	$SpotLight3D.rotation = Vector3(camera.rotation.x, neck.rotation.y, camera.rotation.z)

func _process(_delta):
	$Pivot/Camera/CanvasLayer6/FPSCounter.text = str(Engine.get_frames_per_second()) + " FPS"
