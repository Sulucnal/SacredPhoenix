extends Node2D


@export var map_data : MapData = MapData.new()

@onready var map_data_trigger: Area2D = $MapDataTrigger
@onready var visible_on_screen_enabler_2d: VisibleOnScreenEnabler2D = $VisibleOnScreenEnabler2D
@onready var area_name: Control = $UI_Overlay/AreaName


func _ready() -> void:
	map_data_trigger.show()
	visible_on_screen_enabler_2d.show()


func _on_map_data_trigger_body_entered(body: Node2D) -> void:
	#debug only
	ReferenceStash.player = body
	#========
	ReferenceStash.current_map_data = map_data
	
	await get_tree().process_frame
	if body is Player:
		AudioPlayer.play_area_music(self)
		show_map_name()
		roll_weather_effect()


func show_map_name() -> void:
	if map_data.show_area_name == false:
		return
	area_name.animate()


func roll_weather_effect() -> void:
	if map_data.weather_pool.is_empty():
		return
	#Logic for the weather pool.
