extends Camera2D


@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


const SHAKE_DURATION : float = 0.01


func move_to_node(target : Node2D, duration : float = 0.25, new_zoom : Vector2 = self.zoom) -> void: # Using a duration of 0.0 = instant "blink" transition.
	_camera_movement(target.global_position, duration, new_zoom, false, true)


func move_to_absolute_coords(coordinates : Vector2, duration : float = 0.25, new_zoom : Vector2 = self.zoom) -> void:
	_camera_movement(coordinates, duration, new_zoom, false, true)


func move_to_relative_coords(coordinates : Vector2, duration : float = 0.25, new_zoom : Vector2 = self.zoom, is_vfx : bool = false, _from : Variant = null) -> void:
	_camera_movement(coordinates, duration, new_zoom, is_vfx)


func _camera_movement(target_position : Vector2, duration : float = 0.25, target_zoom : Vector2 = self.zoom, is_vfx : bool = false, is_absolute = false, from : Variant = null) -> void:
	var property : String = "position"
	if is_absolute:
		property = "global_position"
	if from == null:
		var tween : Tween = create_tween()
		tween.tween_property(self, property, target_position, duration).set_ease(Tween.EASE_OUT).from_current()
		tween.parallel().tween_property(self, "zoom", target_zoom, duration).from_current()
		await tween.finished
	else:
		var tween : Tween = create_tween()
		tween.tween_property(self, property, target_position, duration).set_ease(Tween.EASE_OUT).from(from)
		tween.parallel().tween_property(self, "zoom", target_zoom, duration).from(from)
		await tween.finished
	if duration != 0.0 and is_vfx == false:
		Events.ui_animation_finished.emit()


func flash(duration : float = 0.5, hold_time : float = 0.0, color : Color = Color(1,1,1), play_sound : bool = true, custom_sound : AudioStream = null) -> void:
	var half_duration : float = duration / 2
	color_rect.color = color
	if custom_sound != null:
		audio_stream_player.stream = custom_sound
	if audio_stream_player.stream != null and play_sound == true:
		audio_stream_player.play()
	var tween : Tween = create_tween()
	tween.tween_property(color_rect, "modulate", Color(1,1,1,1), half_duration).set_ease(Tween.EASE_IN)
	tween.tween_property(color_rect, "modulate", Color(1,1,1,0), half_duration).set_ease(Tween.EASE_OUT).set_delay(hold_time)
	await tween.finished
	Events.ui_animation_finished.emit()
	if duration != 0.0:
		Events.ui_animation_finished.emit()


func horizontal_screen_shake(intensity : float = 10.0, duration : float = 0.5, play_sound : bool = true, custom_sound : AudioStream = null) -> void:
	var starting_position : Vector2 = self.global_position
	
	if custom_sound != null:
		audio_stream_player.stream = custom_sound
	if audio_stream_player.stream != null and play_sound == true:
		audio_stream_player.play()
		
	@warning_ignore("narrowing_conversion")
	var repetitions : int = duration / (SHAKE_DURATION * 2) - 1
	move_to_relative_coords(Vector2(-(intensity / 2), 0), SHAKE_DURATION, self.zoom, true)
	await get_tree().create_timer(SHAKE_DURATION).timeout
	for repetition in range(repetitions):
		starting_position = self.get_parent().global_position
		move_to_relative_coords(Vector2(intensity, 0), SHAKE_DURATION, self.zoom , true)
		await get_tree().create_timer(SHAKE_DURATION).timeout
		move_to_relative_coords(Vector2(-intensity, 0), SHAKE_DURATION, self.zoom, true)
		await get_tree().create_timer(SHAKE_DURATION).timeout
	starting_position = self.get_parent().global_position
	move_to_absolute_coords(starting_position,SHAKE_DURATION, self.zoom)
	await get_tree().create_timer(SHAKE_DURATION).timeout
	Events.ui_animation_finished.emit()
	
	
func vertical_screen_shake(intensity : float = 10.0, duration : float = 0.5, play_sound : bool = true, custom_sound : AudioStream = null) -> void:
	var starting_position : Vector2 = self.global_position
	
	if custom_sound != null:
		audio_stream_player.stream = custom_sound
	if audio_stream_player.stream != null and play_sound == true:
		audio_stream_player.play()
		
	var repetitions : int = duration / (SHAKE_DURATION * 2) - 1
	move_to_relative_coords(Vector2(0, -(intensity / 2)), SHAKE_DURATION, self.zoom, true)
	await get_tree().create_timer(SHAKE_DURATION).timeout
	for repetition in range(repetitions):
		starting_position = self.get_parent().global_position
		move_to_relative_coords(Vector2(0, intensity), SHAKE_DURATION, self.zoom , true)
		await get_tree().create_timer(SHAKE_DURATION).timeout
		move_to_relative_coords(Vector2(0, -intensity), SHAKE_DURATION, self.zoom, true)
		await get_tree().create_timer(SHAKE_DURATION).timeout
	starting_position = self.get_parent().global_position
	move_to_absolute_coords(starting_position,SHAKE_DURATION, self.zoom)
	await get_tree().create_timer(SHAKE_DURATION).timeout
	Events.ui_animation_finished.emit()
	
	
func screen_shake(intensity : float = 10.0, duration : float = 0.5, play_sound : bool = true, custom_sound : AudioStream = null) -> void:
	var starting_position : Vector2 = self.global_position
	
	if custom_sound != null:
		audio_stream_player.stream = custom_sound
	if audio_stream_player.stream != null and play_sound == true:
		audio_stream_player.play()
		
	var repetitions : int = (duration / (SHAKE_DURATION * 2) * 2) - 1
	randomize()
	var new_position : Vector2 = Vector2(randf_range(-intensity, intensity),randf_range(-intensity, intensity))
	move_to_relative_coords(new_position, SHAKE_DURATION, self.zoom, true, starting_position)
	await get_tree().create_timer(SHAKE_DURATION).timeout
	for repetition in range(repetitions):
#		starting_position = self.get_parent().global_position
		randomize()
		new_position = Vector2(randf_range(-intensity, intensity),randf_range(-intensity, intensity))
		move_to_relative_coords(new_position, SHAKE_DURATION, self.zoom , true, starting_position)
		await get_tree().create_timer(SHAKE_DURATION).timeout
	starting_position = self.get_parent().global_position
	move_to_absolute_coords(starting_position, SHAKE_DURATION, self.zoom)
	await get_tree().create_timer(SHAKE_DURATION).timeout
	Events.ui_animation_finished.emit()
