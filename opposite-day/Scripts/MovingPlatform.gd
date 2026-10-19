extends Area2D

# How far to slide away when the player gets close
@export var move_distance: float = 200.0
# How fast the block moves
@export var move_speed: float = 0.3


var has_moved: bool = false

func _on_body_entered(body: Node2D) -> void:
# 1. Triggers when the player enters the tall detection box (DODGES)
	if body.name == "Player" and not has_moved:
		has_moved = true
		# Slide the entire block out of the way
		var parent_node = get_parent()
		var tween = create_tween()
		tween.tween_property(parent_node, "position:x", parent_node.position.x - move_distance, move_speed)
