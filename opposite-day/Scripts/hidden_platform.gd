extends StaticBody2D

@onready var platform_sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Make sure it starts hidden when Level loads
	platform_sprite.visible = false

# Triggered when player touches the TriggerArea
func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and not platform_sprite.visible:
		platform_sprite.visible = true
		platform_sprite.modulate.a = 0.0
		
		# Fade in transparency from 0 to 1 over 0.3 seconds
		var tween = create_tween()
		tween.tween_property(platform_sprite, "modulate:a", 1.0, 0.3)
