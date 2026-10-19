extends Area2D

# How far to slide away when the player gets close
@export var move_distance: float = 200.0
# How fast the block moves
@export var move_speed: float = 0.3

@onready var popup_text: Label = $"../../popup_text"

var has_moved: bool = false

func _on_body_entered(body: Node2D) -> void:
# 1. Triggers when the player enters the tall detection box (DODGES)
	if body.name == "Player" and not has_moved:
		has_moved = true
# Show the text!
		if popup_text:
			popup_text.visible = true
		
		# Slide the entire block out of the way
		var parent_node = get_parent()
		var tween = create_tween()
		tween.tween_property(parent_node, "position:x", parent_node.position.x - move_distance, move_speed)


# 2. Triggers if the player actually touches the kill shape (KILLS)
func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file("res://Sceans/leval_1.tscn")
	if body.is_in_group("Player") or body is CharacterBody2D:
		GameManager.add_death()
		get_tree().reload_current_scene()
