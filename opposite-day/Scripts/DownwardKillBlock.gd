extends Area2D

@export var move_distance: float = 599.0 # Distance to drop downward
@export var move_speed: float = 4.0      # Speed of the drop

var has_moved: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body is CharacterBody2D or body.name == "Player":
		# Slide the kill block down to crush the player
		if not has_moved:
			has_moved = true
			var parent_block = get_parent()
			
			if parent_block:
				var tween = create_tween()
				tween.tween_property(parent_block, "position:y", parent_block.position.y + move_distance, move_speed)
				tween.tween_interval(1.67)
				tween.tween_callback(show_label)
				tween.tween_callback(parent_block.queue_free)

func show_label() -> void:
	var current_level = get_tree().current_scene
	if current_level and current_level.has_node("Label2"):
		current_level.get_node("Label2").visible = true
