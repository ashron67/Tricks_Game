extends Node2D

@onready var time_label: Label = $score/Scors/Time
@onready var deaths_label: Label = $score/Scors/deaths
@onready var best_time_label: Label = $"score/Scors/Best time"

func _ready() -> void:
	# 1. Set camera boundaries for Level 10
	var camera = $Player/Camera2D
	if camera:
		camera.limit_left = -1000
		camera.limit_right = 10690
		camera.limit_bottom = 400

	# 2. Freeze timer and save high score record
	GameManager.record_completion()

	# 3. Update scoreboard labels
	if time_label:
		time_label.text = "Time: " + GameManager.get_formatted_time()
	elif has_node("score/Time"):
		$score/Time.text = "Time: " + GameManager.get_formatted_time()

	if deaths_label:
		deaths_label.text = "Deaths: %04d" % GameManager.death_count

	if best_time_label:
		best_time_label.text = "Best Time: " + GameManager.get_formatted_best_time()
