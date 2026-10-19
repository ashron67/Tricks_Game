extends TextureButton

# Path to your first level
@export var level_1_path: String = "res://Sceans/leval_1.tscn"

# Darkening tint (0.8 lowers brightness to 80%)
@export var hover_darken_color: Color = Color(0.8, 0.8, 0.8, 1.0)

# Sound file assigned for clicking
@export var click_sound: AudioStream = preload("res://Assets/Sounds/Start button.mp3")

var original_position: Vector2
var original_scale: Vector2
var audio_player: AudioStreamPlayer

func _ready() -> void:
	# Center the pivot point so scaling expands outward evenly
	pivot_offset = size / 2.0
	original_scale = scale
	original_position = position

	# Set up audio player node automatically
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = click_sound
	add_child(audio_player)

	# Connect button signals
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	# Expand size and darken smoothly on hover
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", original_scale * 1.15, 0.15)
	tween.tween_property(self, "modulate", hover_darken_color, 0.15)

func _on_mouse_exited() -> void:
	# Return to original size and brightness when cursor leaves
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", original_scale, 0.15)
	tween.tween_property(self, "modulate", Color.WHITE, 0.15)

func _on_pressed() -> void:
	# Prevent double clicks while waiting
	disabled = true

	# Button shake effect
	var shake_tween = create_tween()
	var offset: float = 6.0
	
	shake_tween.tween_property(self, "position", original_position + Vector2(-offset, 0), 0.03)
	shake_tween.tween_property(self, "position", original_position + Vector2(offset, 0), 0.03)
	shake_tween.tween_property(self, "position", original_position + Vector2(-offset, 0), 0.03)
	shake_tween.tween_property(self, "position", original_position, 0.03)

	# Play click sound and pause code execution until the audio clip finishes
	if audio_player and audio_player.stream:
		audio_player.play()
		await audio_player.finished
	else:
		await shake_tween.finished

	get_tree().change_scene_to_file(level_1_path)
