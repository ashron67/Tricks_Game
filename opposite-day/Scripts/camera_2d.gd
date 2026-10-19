extends Camera2D

func _ready() -> void:
	# Set pixel limits based on your level size
	limit_left = -1000
	limit_right = 845 # Adjust to the right most pixel edge of your platform   # Optional top boundary
	limit_bottom = 400 
