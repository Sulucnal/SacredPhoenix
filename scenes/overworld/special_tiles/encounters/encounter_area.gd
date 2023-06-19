extends Area2D
class_name EncounterArea


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		randomize()
		var chance : int = randi_range(1,20)
		if chance == 1:
			get_tree().paused = true
			AudioPlayer.play_music("res://assets/audio/music/Battle - Wild of Keltios.ogg")
			animate_transition()
			SceneStack.push("res://scenes/battle/battle.tscn")


func animate_transition() -> void:
	pass
