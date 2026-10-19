extends Sprite2D

@export_group("Side-to-Side Sway")
@export var sway_speed: float = 2.0        # Speed of horizontal movement
@export var sway_distance: float = 15.0    # Pixels to move left and right

@export_group("Hover Settings")
@export var hover_scale: float = 1.15      # Size multiplier on hover (115%)
@export var animate_time: float = 0.15     # Transition speed

var base_position: Vector2
var base_scale: Vector2
var time_passed: float = 0.0
var is_hovered: bool = false
var scale_tween: Tween

func _ready() -> void:
	base_position = position
	base_scale = scale

func _process(delta: float) -> void:
	# 1. Side-to-Side Swaying Motion
	time_passed += delta * sway_speed
	position.x = base_position.x + (sin(time_passed) * sway_distance)

	# 2. Mouse Hover Detection for Sprite2D
	var mouse_pos = to_local(get_global_mouse_position())
	var hovering = get_rect().has_point(mouse_pos)

	if hovering != is_hovered:
		is_hovered = hovering
		_animate_hover(is_hovered)

func _animate_hover(hovered: bool) -> void:
	if scale_tween:
		scale_tween.kill()
		
	var target_scale = base_scale * hover_scale if hovered else base_scale
	
	scale_tween = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	scale_tween.tween_property(self, "scale", target_scale, animate_time)
