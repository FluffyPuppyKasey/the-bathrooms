extends CharacterBody3D

var SPEED = 2.5
var SPRINTSPEED = SPEED * 2
const JUMP_VELOCITY = 4.5

var minFOV = 25.0
var maxFOV = 75.0

var timeNow = Time.get_ticks_usec()

var controllerLook = Input.get_vector("joyLookUp", "joyLookDown", "joyLookLeft", "joyLookRight")


# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var neck := $Pivot
@onready var camera := $Pivot/Camera

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			
			neck.rotate_y(-event.relative.x * 0.005)
			camera.rotate_x(-event.relative.y * 0.005)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
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

# Process mouse and keyboard input
	if Input.is_action_pressed("zoom_in"):
		if $Pivot/Camera.fov >= minFOV:
			var camFOV = $Pivot/Camera.fov
			camFOV = camFOV - 0.13332
			$Pivot/Camera.fov = camFOV

	if Input.is_action_pressed("zoom_out"):
		if $Pivot/Camera.fov <= maxFOV:
			var camFOV = $Pivot/Camera.fov
			camFOV = camFOV + 0.1
			$Pivot/Camera.fov = camFOV
			
	if Input.is_action_pressed("joyLookRight"):
		neck.rotate_y(Input.get_action_strength("joyLookRight") * -0.05)
		
	if Input.is_action_pressed("joyLookLeft"):
		neck.rotate_y(Input.get_action_strength("joyLookLeft") * 0.05)
	
	if Input.is_action_pressed("joyLookUp"):
		camera.rotation.x -= Input.get_action_strength("joyLookUp") * -0.05
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
	if Input.is_action_pressed("joyLookDown"):
		camera.rotation.x -= Input.get_action_strength("joyLookDown") * 0.05
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
