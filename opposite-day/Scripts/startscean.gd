extends Node2D

@export var hover_sound: AudioStream = preload("res://Assets/Sounds/Mouse hover.mp3")

@onready var title_label: Label = $Titel
@onready var play_button: TextureButton = $Playboutton
@onready var player_icon: Sprite2D = $Playericon

var hover_player: AudioStreamPlayer
var is_player_icon_hovered: bool = false

func _ready() -> void:
	# Create dedicated audio player for hover effects
	hover_player = AudioStreamPlayer.new()
	hover_player.stream = hover_sound
	add_child(hover_player)

	# Connect UI hover signals for Label & Button
	if title_label:
		title_label.mouse_filter = Control.MOUSE_FILTER_STOP
		title_label.mouse_entered.connect(_play_hover)

	if play_button:
		play_button.mouse_entered.connect(_play_hover)

func _process(_delta: float) -> void:
	# Detect mouse hover over Playericon (Sprite2D)
	if player_icon:
		var mouse_pos = player_icon.to_local(get_global_mouse_position())
		var hovering = player_icon.get_rect().has_point(mouse_pos)

		if hovering and not is_player_icon_hovered:
			is_player_icon_hovered = true
			_play_hover()
		elif not hovering:
			is_player_icon_hovered = false

func _play_hover() -> void:
	if hover_player and hover_player.stream:
		hover_player.play()
