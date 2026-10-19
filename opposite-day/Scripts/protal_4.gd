extends Area2D
@export_file("*.tscn") var target_level: String = "res://Sceans/level_5.tscn"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if target_level != "":
			get_tree().change_scene_to_file(target_level)
