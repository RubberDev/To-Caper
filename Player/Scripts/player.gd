class_name Player
extends CharacterBody3D

@export var Process : bool = true

const DEFAULT_SPEED = 2.5
var SPEED = 2.5
var CROUCH_SPEED = 0.5
var JUMP_VELOCITY = 4.5
var SENSITIVITY = 0.005

var is_paused : bool = false
var is_crouched : bool = false
var sprinting : bool = false

enum {IDLE, WALK, CROUCH, CROUCHWALK, SPRINT}
var Current_Anim = IDLE
@onready var Anim_Tree = $AnimationTree
@export var Blend_Speed : int = 15
var walk_val : float = 0.0
var jump_val : float = 0.0
var cidle_val : float = 0.0
var cwalk_val : float = 0.0
var sprint_val : float = 0.0

var money = 0.0

func handle_anims(delta):
	match Current_Anim:
		IDLE:
			walk_val = lerpf(walk_val, 0.0, Blend_Speed * delta)
			cidle_val = lerpf(cidle_val, 0.0, Blend_Speed * delta)
			cwalk_val = lerpf(cwalk_val, 0.0, Blend_Speed * delta)
			sprint_val = lerpf(sprint_val, 0.0, Blend_Speed * delta)
		WALK:
			walk_val = lerpf(walk_val, 1.0, Blend_Speed * delta)
			cidle_val = lerpf(cidle_val, 0.0, Blend_Speed * delta)
			cwalk_val = lerpf(cwalk_val, 0.0, Blend_Speed * delta)
			sprint_val = lerpf(sprint_val, 0.0, Blend_Speed * delta)
		CROUCH:
			walk_val = lerpf(walk_val, 0.0, Blend_Speed * delta)
			cidle_val = lerpf(cidle_val, 1.0, Blend_Speed * delta)
			cwalk_val = lerpf(cwalk_val, 0.0, Blend_Speed * delta)
			sprint_val = lerpf(sprint_val, 0.0, Blend_Speed * delta)
		CROUCHWALK:
			walk_val = lerpf(walk_val, 0.0, Blend_Speed * delta)
			cidle_val = lerpf(cidle_val, 0.0, Blend_Speed * delta)
			cwalk_val = lerpf(cwalk_val, 1.0, Blend_Speed * delta)
			sprint_val = lerpf(sprint_val, 0.0, Blend_Speed * delta)
		SPRINT:
			walk_val = lerpf(walk_val, 0.0, Blend_Speed * delta)
			cidle_val = lerpf(cidle_val, 0.0, Blend_Speed * delta)
			cwalk_val = lerpf(cwalk_val, 0.0, Blend_Speed * delta)
			sprint_val = lerpf(sprint_val, 1.0, Blend_Speed * delta)

func update_tree():
	Anim_Tree["parameters/Walk Blend/blend_amount"] = walk_val
	Anim_Tree["parameters/CrouchIdleBlend/blend_amount"] = cidle_val
	Anim_Tree["parameters/CrouchWalkBlend/blend_amount"] = cwalk_val
	Anim_Tree["parameters/SprintBlend/blend_amount"] = sprint_val

func Free_Mouse():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func Jail_Mouse():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$AnimationTree.active = true

func _physics_process(delta: float) -> void:
	handle_anims(delta)
	update_tree()
	
	if Process == true:
		set_deferred("process_mode", PROCESS_MODE_INHERIT)
	else:
		set_deferred("process_mode", PROCESS_MODE_DISABLED)
	
	if $PlyrCamera3D/IntCheck.is_colliding():
		var Collider = $PlyrCamera3D/IntCheck.get_collider()
		if Collider.has_method("interact"):
			if Input.is_action_just_pressed("Interact"):
				print("test")
				Collider.interact()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$Sound/PlayerJump.play()
		

	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			if is_crouched == false and sprinting == false:
				Current_Anim = WALK
			elif is_crouched == true and sprinting == false:
				Current_Anim = CROUCHWALK
			elif is_crouched == false and sprinting == true:
				Current_Anim = SPRINT
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		if is_on_floor():
			if is_crouched == false:
				Current_Anim = IDLE
			if is_crouched == true:
				Current_Anim = CROUCH

	move_and_slide()

func _process(_delta: float) -> void:
	$Control/Panel/Label.text = "$" + str(money)
	
	if $PlyrCamera3D/IntCheck.is_colliding():
		var Collider = $PlyrCamera3D/IntCheck.get_collider()
		if Input.is_action_just_pressed("Interact"):
			print("Pressed interact")
			if Collider.has_method("interact") or Collider.is_in_group("Interactable"):
				print("Firing method")
				Collider.interact()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if is_paused == false:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				rotate_y(-event.relative.x * SENSITIVITY)
				$PlyrCamera3D.rotate_x(-event.relative.y * SENSITIVITY)
				$PlyrCamera3D.rotation.x = clamp($PlyrCamera3D.rotation.x, -PI/2, PI/2)
	
	if Input.is_action_pressed("Crouch"):
		is_crouched = true
		$CollisionBody.set_deferred("disabled", true)
		if is_on_floor():
			SPEED = CROUCH_SPEED
	elif Input.is_action_just_released("Crouch"):
		if $RayCast3D.is_colliding() == false:
			is_crouched = false
			$CollisionBody.set_deferred("disabled", false)
			SPEED = DEFAULT_SPEED
	
	if Input.is_action_pressed("Sprint"):
		if is_crouched == false:
			sprinting = true
			SPEED = 5.0
	elif Input.is_action_just_released("Sprint"):
		if is_crouched == false:
			sprinting = false
			SPEED = DEFAULT_SPEED
