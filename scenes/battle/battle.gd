extends Node2D


@onready var opponent_sprite: TextureRect = $OpponentSprite


var pokemon_to_fight : Pokemon

var math : Math = Math.new()


func _ready() -> void:
	if ReferenceStash.current_battle_type == "Wild":
		set_wild_encounter()
	else:
		pass


func _input(event: InputEvent) -> void:
	debug() # Should be deleted later


func debug() -> void: # Should be deleted later
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = false
		SceneStack.pop()


func set_wild_encounter() -> void:
	pokemon_to_fight = Pokemon.new()
	pokemon_to_fight.species = (math.random_weighted(ReferenceStash.current_encounter_pool)).species
	opponent_sprite.texture = pokemon_to_fight.species.spritesheet.get_frame_texture("Front", 0)
	print("You are fighting a " + pokemon_to_fight.species.name)
