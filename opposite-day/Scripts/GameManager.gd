extends Node

# Core Stats & Timer
var elapsed_time: float = 0.0
var timer_running: bool = false
var death_count: int = 0
var best_time: float = 0.0 # 0.0 indicates no record set yet
var is_dying: bool = false

# Global Audio & Mute State
var is_muted: bool = false
@export var soundtrack_stream: AudioStream = preload("res://Assets/Sounds/Soundtrack.mp3")
@export var normal_volume_db: float = -6.0
@export var low_volume_db: float = -15.0

var music_player: AudioStreamPlayer
var has_started_music: bool = false
var volume_tween: Tween

func _ready() -> void:
	music_player = AudioStreamPlayer.new()
	music_player.stream = soundtrack_stream
	add_child(music_player)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_F11:
		var current_mode = DisplayServer.window_get_mode()
		if current_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN or current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)

func _process(delta: float) -> void:
	if timer_running:
		elapsed_time += delta

# Audio Controls & Volume Fading
func start_soundtrack() -> void:
	update_volume_for_level()

	if not has_started_music:
		has_started_music = true
		if music_player and not music_player.playing:
			music_player.play()

func update_volume_for_level() -> void:
	var current_scene = get_tree().current_scene
	if not current_scene or not music_player:
		return

	var is_level_10: bool = "10" in current_scene.scene_file_path or "10" in current_scene.name
	var target_db: float = low_volume_db if is_level_10 else normal_volume_db

	if music_player.volume_db != target_db:
		if volume_tween:
			volume_tween.kill()
		volume_tween = create_tween()
		volume_tween.tween_property(music_player, "volume_db", target_db, 1.2)

func toggle_mute() -> void:
	is_muted = !is_muted
	var master_bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus_index, is_muted)

# Death & Reset Mechanics with Screen Shake
func add_death() -> void:
	death_count += 1

func player_died() -> void:
	if is_dying:
		return
	is_dying = true

	add_death()

	# Find active camera and execute smooth screen shake
	var camera = get_viewport().get_camera_2d()
	if camera:
		var tween = create_tween()
		var original_offset = camera.offset

		# Rapid shake offset sequence
		for i in range(5):
			var shake_offset = Vector2(randf_range(-8.0, 8.0), randf_range(-8.0, 8.0))
			tween.tween_property(camera, "offset", shake_offset, 0.04)

		# Return camera to original position before scene switch
		tween.tween_property(camera, "offset", original_offset, 0.04)
		await tween.finished

	reset_timer()
	is_dying = false
	get_tree().change_scene_to_file("res://Sceans/leval_1.tscn")

func reset_timer() -> void:
	elapsed_time = 0.0
	timer_running = false

# Score & Record Tracking
func record_completion() -> void:
	timer_running = false
	
	if best_time == 0.0 or elapsed_time < best_time:
		best_time = elapsed_time

func get_formatted_time() -> String:
	var total_seconds: int = int(elapsed_time)
	var tenths: int = int(fmod(elapsed_time, 1.0) * 10)
	return "%03d.%d" % [total_seconds, tenths]

func get_formatted_best_time() -> String:
	if best_time == 0.0:
		return "000.0"
	var total_seconds: int = int(best_time)
	var tenths: int = int(fmod(best_time, 1.0) * 10)
	return "%03d.%d" % [total_seconds, tenths]
