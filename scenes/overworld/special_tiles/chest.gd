extends Interactable


@export var content : ItemQuantity
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable: Area2D = $Interactable


func _run_interaction() -> void:
	get_tree().paused = true
	interactable.queue_free()
	animated_sprite_2d.play("default")
	await animated_sprite_2d.animation_finished
	ReferenceStash.dialog_item = content
	var resource = preload("res://dialogs/get_item.dialogue")
	DialogueManager.show_example_dialogue_balloon(resource)
	if ReferenceStash.dialog_item.item.name == "Scepter of Phoenix":
		ReferenceStash.player.player_data.has_scepter = true
		ReferenceStash.player.player_skin_scepter = ""
	await DialogueManager.dialogue_ended
	get_tree().paused = false
