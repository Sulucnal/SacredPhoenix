extends Node2D


@export var map_data : MapData



func _on_map_data_trigger_body_entered(body: Node2D) -> void:
	await get_tree().physics_frame
	if body is Player:
		AudioPlayer.play_area_music(self)
		show_map_name()
		roll_weather_effect()


func show_map_name() -> void:
	if map_data.show_area_name == false:
		return
	#Logic for showing the map name on the UI.


func roll_weather_effect() -> void:
	if map_data.weather_pool.is_empty():
		return
	#Logic for the weather pool.
