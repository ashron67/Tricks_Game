extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body is CharacterBody2D or body.name == "Player":
		GameManager.player_died()
