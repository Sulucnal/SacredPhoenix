extends Node2D


func _input(event: InputEvent) -> void:
	debug() # Should be deleted later


func debug() -> void: # Should be deleted later
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		SceneStack.pop()
