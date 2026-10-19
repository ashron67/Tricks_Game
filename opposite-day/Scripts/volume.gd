extends Control

@onready var volume_up = $VolumeUp
@onready var mute_icon = $Mute

func _ready() -> void:
	update_visuals()

func update_visuals() -> void:
	# Shows VolumeUp when unmuted, hides it and shows Mute when muted
	volume_up.visible = not GameManager.is_muted
	mute_icon.visible = GameManager.is_muted

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameManager.toggle_mute()
		update_visuals()
