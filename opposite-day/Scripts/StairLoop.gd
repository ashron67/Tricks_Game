extends Area2D

@export var teleport_offset: Vector2 = Vector2(1535, 384)

var loop_count: int = 0

func _ready() -> void:
	# Hide "It really is unending" text at the start
	if has_node("../Label"):
		$"../Label".visible = false

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		loop_count += 1
		
		# 1. Teleport player back down
		body.global_position += teleport_offset
		
		# 2. Prevent camera smoothing jump
		var camera = body.get_node_or_null("Camera2D")
		if camera:
			camera.reset_smoothing()
			
		# 3. Loop effects
		if loop_count == 1:
			# First loop: Show "It really is unending"
			if has_node("../Label"):
				$"../Label".visible = true
			if has_node("../Label2"):
				$"../Label2".visible = false
		elif loop_count == 2:
			# Second loop: Hide "The Unending Stairs" (Label2)
			if has_node("../Label3"):
				$"../Label3".visible = true
			if has_node("../Label"):
				$"../Label".visible = false
		elif loop_count == 3:
			if has_node("../Label4"):
				$"../Label4".visible = true
			if has_node("../Label3"):
				$"../Label3".visible = false
		elif loop_count == 4:
			if has_node("../Label5"):
				$"../Label5".visible = true
			if has_node("../Label4"):
				$"../Label4".visible = false
		elif loop_count == 5:
			if has_node("../Label6"):
				$"../Label6".visible = true
			if has_node("../Label5"):
				$"../Label5".visible = false
		elif loop_count == 6:
			if has_node("../Label7"):
				$"../Label7".visible = true
			if has_node("../Label6"):
				$"../Label6".visible = false
		elif loop_count == 7:
			if has_node("../Label8"):
				$"../Label8".visible = true
			if has_node("../Label7"):
				$"../Label7".visible = false
		elif loop_count == 8:
			if has_node("../Label9"):
				$"../Label9".visible = true
			if has_node("../Label8"):
				$"../Label8".visible = false
		elif loop_count >= 9:
			if has_node("../Label10"):
				$"../Label10".visible = true
			if has_node("../Label9"):
				$"../Label9".visible = false
