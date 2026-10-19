extends Node2D

@export_group("Idle Bounce & Shake")
@export var bounce_speed: float = 3.5        # Speed of the rhythm
@export var bounce_height: float = 7.0       # Up & down pixel motion
@export var shake_amount: float = 0.04       # Subtle rotation wobble angle

@export_group("Hover Settings")
@export var hover_scale: float = 1.15        # Scale expansion multiplier (15% bigger)
@export var animate_time: float = 0.15       # Transition speed in seconds

var base_position: Vector2
var base_scale: Vector2
var time_passed: float = 0.0
var is_hovered: bool = false
var scale_tween: Tween

func _ready() -> void:
	base_position = position
	base_scale = scale
	time_passed = randf() * 10.0 # Offsets the timing so items don't bounce identically

	# Set pivot to center if node is a Sprite2D
	if self is Sprite2D:
		centered = true

	# Connect collision-based hover signals if available (CharacterBody2D / Area2D)
	if has_signal("mouse_entered"):
		mouse_entered.connect(_on_mouse_entered)
		mouse_exited.connect(_on_mouse_exited)

func _process(delta: float) -> void:
	# --- 1. Continuous Idle Bounce & Shake ---
	time_passed += delta * bounce_speed
	position.y = base_position.y + (sin(time_passed) * bounce_height)
	rotation = sin(time_passed * 1.3) * shake_amount

	# --- 2. Automatic Hover Check for Sprite2D ---
	if self is Sprite2D:
		var mouse_pos = to_local(get_global_mouse_position())
		var hovering = get_rect().has_point(mouse_pos)
		if hovering != is_hovered:
			if hovering:
				_on_mouse_entered()
			else:
				_on_mouse_exited()

func _on_mouse_entered() -> void:
	is_hovered = true
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", base_scale * hover_scale, animate_time)

func _on_mouse_exited() -> void:
	is_hovered = false
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", base_scale, animate_time)
