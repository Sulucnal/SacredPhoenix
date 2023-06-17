extends Node


var player : CharacterBody2D


func stash_player(player_to_stash : CharacterBody2D) -> void:
	player = player_to_stash
	player.get_parent().remove_child(player)


func map_swap(player_to_stash : CharacterBody2D, new_level_string : String) -> void:
	stash_player(player_to_stash)
	get_tree().change_scene_to_file(new_level_string)
	drop_player()


func drop_player() -> void:
	await get_tree().process_frame
	var parent : Node = get_tree().current_scene
	var player_parent := parent.get_node("PixelArt/Maps")
	player_parent.add_child(player)
	player.owner = player_parent
	for warp in get_tree().get_nodes_in_group("MapTransitionArea"):
		if warp.connection_id != player.terrain_detector.last_warp_connection_id:
			continue
		player.global_position = warp.drop_point.global_position
	get_tree().paused = false
