extends Node


const DURATION : float = 0.5


@onready var music: AudioStreamPlayer = $Music
@onready var sound_effects: AudioStreamPlayer = $SoundEffects


func play_area_music(area : Node2D) -> void:
	var new_bgm : AudioStream = area.map_data.bgm
	_change_bgm(new_bgm)


func play_music(bgm_path : String) -> void:
	var new_bgm : AudioStream = load(bgm_path)
	_change_bgm(new_bgm)
	

func play_music_fade(bgm_path : String) -> void:
	var new_bgm : AudioStream = load(bgm_path)
	_change_bgm(new_bgm, -80.0)


func _change_bgm(new_bgm : AudioStream, starting_volume : float = 0.0) -> void:
	if music.stream != null:
		var tween_fade_out : Tween = create_tween()
		tween_fade_out.tween_property(music, "volume_db", -80.0, DURATION) 
		await tween_fade_out.finished
	music.stream = new_bgm
	music.volume_db = starting_volume
	music.play()
	var tween_fade_in : Tween = create_tween()
	tween_fade_in.tween_property(music, "volume_db", 0.0, DURATION) 


func play_sound(sound_path : String, pause_bgm : bool = true) -> void:
	var new_sound : AudioStream = load(sound_path)
	sound_effects.stream = new_sound
	if music.playing == true and pause_bgm == true:
		music.stream_paused = true
	sound_effects.play()
	if music.stream != null and pause_bgm == true:
		await sound_effects.finished
		music.stream_paused = false
