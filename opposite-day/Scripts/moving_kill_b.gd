extends Area2D

# How far to slide to the left (in pixels)
@export var move_distance: float = 300
# How fast it opens (in seconds)
@export var open_duration: float = 0.3 

var is_open: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		# Optional: If you want touching it to kill the player, keep this line:
		# get_tree().change_scene_to_file("res://Sceans/leval_1.tscn")
		
		# Open the trap door if it hasn't opened yet
		if not is_open:
			open_trapdoor()

func open_trapdoor() -> void:
	is_open = true
	
	# Create a smooth sliding animation
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x - move_distance, open_duration)
