extends CharacterBody3D

@onready var camera = $CameraPivot/Camera3D
@onready var model = $CollisionShape3D/ModelMesh
@onready var vehicle = $VehicleMesh

const SPEED: float = 15.0
const ACCELERATION: float = 12.0
const DECELERATION: float = 5.0
const JUMP_VELOCITY: float = 4.5
const STEERING_STRENGTH: float = 12.0
const TILT_ANGLE: float = deg_to_rad(20)
const TILT_STRENGTH: float = 0.05
const TURN_SPEED: float = 0.05

var acceleration = 80
var model_tilt := 0

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_pressed("rotate_left"):
		rotation.y += TURN_SPEED
		model.rotation.z = lerp(vehicle.rotation.z, TILT_ANGLE, TILT_STRENGTH)
		vehicle.rotation.z = lerp(vehicle.rotation.z, TILT_ANGLE, TILT_STRENGTH)
		#TODO: offset camera a little
	elif Input.is_action_pressed("rotate_right"):
		rotation.y -= TURN_SPEED
		model.rotation.z = lerp(model.rotation.z, -TILT_ANGLE, TILT_STRENGTH)
		vehicle.rotation.z = lerp(model.rotation.z, -TILT_ANGLE, TILT_STRENGTH)
		#$CameraPivot.transform.basis.x = 5.0
	else:
		model.rotation.z = lerp(model.rotation.z, 0.0, TILT_STRENGTH)
		vehicle.rotation.z = lerp(vehicle.rotation.z, 0.0, TILT_STRENGTH)
		#$CameraPivot.transform.basis.x = 0.0
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.05)
		velocity.z = lerp(velocity.z, 0.0, 0.05)

	move_and_slide()
