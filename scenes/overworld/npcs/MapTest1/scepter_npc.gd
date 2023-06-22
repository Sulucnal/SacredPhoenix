extends Interactable


var dialog : DialogueResource = preload("res://dialogs/scepter_npc.dialogue")


func _run_interaction() -> void:
	get_tree().paused = true
	DialogueManager.show_example_dialogue_balloon(dialog)
	await DialogueManager.dialogue_ended
	get_tree().paused = false
