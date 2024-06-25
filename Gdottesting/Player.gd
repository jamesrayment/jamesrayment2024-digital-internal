extends CharacterBody3D


var SPEED = 5.0
const JUMP_VELOCITY = 4.5

#crouching
@export var ANIMATIONPLAYER : AnimationPlayer
@export_range(5, 10, 0.1) var crouch_speed : float = 7.0

@onready var pivot = get_node("/root/Node3D/Player/CollisionShape3D")
@onready var camera = get_node("/root/Node3D/Player/CollisionShape3D/Neck")
var sensitivity = 0.01

@onready var global = get_node("/root/Global")

@onready var coins_group = get_tree().get_nodes_in_group("coins")
var total_coins = 0
var double_jump

var _is_crouching : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	for coin in coins_group:
		total_coins += 1
		print(total_coins)
		
	total_coins = len(coins_group)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			pivot.rotate_y(-event.relative.x * sensitivity / 2)
			camera.rotate_x(-event.relative.y * sensitivity / 4)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(+90))

func _input(event):
	if event.is_action_pressed("Crouch"):
		toggle_crouch()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		double_jump = true
	elif Input.is_action_just_pressed("ui_accept") and double_jump == true and not is_on_floor():
		velocity.y = JUMP_VELOCITY * 1.10
		double_jump = false

	# Controls for movement (WASD and camera following movement)
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (pivot.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	global.player_coins += 1
	#print(global.player_coins)

	#sprint mechanics
	if Input.is_action_just_pressed("Shift"):
		SPEED = 10.0
	elif Input.is_action_just_released("Shift"):
		SPEED = 5.0

func toggle_crouch():
	if _is_crouching == true:
		ANIMATIONPLAYER.play("crouch", -1, -crouch_speed, true)
	elif _is_crouching == false:
		ANIMATIONPLAYER.play("crouch", -1, crouch_speed)
	_is_crouching = !_is_crouching
