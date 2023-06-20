extends Area2D
class_name EncounterArea


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		ReferenceStash.current_encounter_pool = set_reference_encounter()
		ReferenceStash.current_battle_type = "Wild"
		randomize()
		var chance : int = randi_range(1,20)
		if chance == 1:
			get_tree().paused = true
			animate_transition()


func animate_transition() -> void:
	#debug only for now
	ReferenceStash.player.camera.flash(1.0,0.5, Color(0,0,0))
	AudioPlayer.play_music("res://assets/audio/music/Battle - Wild of Keltios.ogg")
	await get_tree().create_timer(1.0).timeout
	start_battle()


func start_battle() -> void:
	# Code to define the Pokémon/trainer you fight against
	SceneStack.push("res://scenes/battle/battle.tscn")


func set_reference_encounter() -> Array[Encounter]:
	# Temporary. Need to use match/if statment depending on the encounter array we want to return.
	return ReferenceStash.current_map_data.encounter_day
