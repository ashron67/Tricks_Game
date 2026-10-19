extends Label

@export_group("Idle Bounce & Shake")
@export var bounce_speed: float = 2        # Speed of the floating rhythm
@export var bounce_height: float = 7.0       # Up & down movement range in pixels
@export var shake_amount: float = 0.04       # Rotation angle wobble

@export_group("Hover Settings")
@export var hover_scale: float = 1.15        # Size multiplier on mouse hover (115%)
@export var animate_time: float = 0.15       # Transition speed

var base_position: Vector2
var base_scale: Vector2
var time_passed: float = 0.0
var scale_tween: Tween

func _ready() -> void:
	# Center the pivot point so scaling expands outward evenly from center
	pivot_offset = size / 2.0
	base_position = position
	base_scale = scale
	time_passed = randf() * 10.0

	# Ensure the Label detects mouse interaction
	mouse_filter = Control.MOUSE_FILTER_STOP

	# Connect Control UI hover signals directly
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(delta: float) -> void:
	# Continuous Idle Bounce & Shake
	time_passed += delta * bounce_speed
	position.y = base_position.y + (sin(time_passed) * bounce_height)
	rotation = sin(time_passed * 1.3) * shake_amount

func _on_mouse_entered() -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", base_scale * hover_scale, animate_time)

func _on_mouse_exited() -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", base_scale, animate_time)
