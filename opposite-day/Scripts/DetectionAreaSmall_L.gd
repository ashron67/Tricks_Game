extends Area2D

@export var move_distance: float = 460.0
@export var move_speed: float = 0.22

var has_moved: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not has_moved:
		has_moved = true
		
		# Moves the AnimatableBody2D parent smoothly to the left
		var parent_node = get_parent()
		var tween = create_tween()
		tween.tween_property(parent_node, "position:x", parent_node.position.x - move_distance, move_speed)
