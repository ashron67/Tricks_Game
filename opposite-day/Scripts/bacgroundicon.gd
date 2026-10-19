extends Node2D # Change to extends TextureRect or Sprite2D if needed

@export var parallax_strength: float = 0.06 # How far the background shifts
@export var smoothness: float = 6.0          # How smoothly it moves

var base_position: Vector2

func _ready() -> void:
	base_position = position

func _process(delta: float) -> void:
	# Calculate offset from center of the screen
	var screen_center = get_viewport_rect().size / 2.0
	var mouse_pos = get_viewport().get_mouse_position()
	var mouse_offset = mouse_pos - screen_center

	# Move in the OPPOSITE direction of the mouse
	var target_position = base_position - (mouse_offset * parallax_strength)

	# Smoothly slide toward target position
	position = position.lerp(target_position, delta * smoothness)
