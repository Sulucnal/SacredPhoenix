extends Button
class_name ParentButton


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


@export var button_sound : AudioStream = null


func _ready() -> void:
	audio_stream_player.stream = button_sound


func _on_mouse_entered() -> void:
	grab_focus()


func _on_focus_entered() -> void:
	if audio_stream_player.stream != null:
		audio_stream_player.play()
