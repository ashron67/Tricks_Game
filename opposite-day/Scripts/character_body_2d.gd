extends CharacterBody2D

const SPEED = 421
const JUMP_VELOCITY = -800.0

@export var spawn_point: Node2D
@onready var SFX_jump = $SFX_jump

func _ready() -> void:
	if spawn_point:
		global_position = spawn_point.global_position
		
	if has_node("WhiteFog"):
		$WhiteFog.visible = get_tree().current_scene.name in ["level_5", "level_6"]

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if SFX_jump:
			SFX_jump.play()

	# Handle horizontal movement
	var is_moving: bool = false
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$sprite.flip_h = false
		is_moving = true
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$sprite.flip_h = true
		is_moving = true
	else:
		velocity.x = 0

	# Emit dust only when moving along the ground
	if has_node("Dust"):
		$Dust.emitting = is_moving and is_on_floor()

	move_and_slide()
	
	# Check for first movement input
	var is_inputting_movement: bool = Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("jump")

	if is_inputting_movement:
		# Only start timer on movement if we are NOT on Level 10
		if not GameManager.timer_running and get_tree().current_scene.name != "level_10":
			GameManager.timer_running = true

		# Tell GameManager to start the music (persists across scene changes)
		GameManager.start_soundtrack()

func _process(_delta: float) -> void:
	if has_node("Timer/HUDTimer"):
		$Timer/HUDTimer.text = " " + GameManager.get_formatted_time()
