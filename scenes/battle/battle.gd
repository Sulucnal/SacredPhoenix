extends Node2D


@onready var opponent_sprite: TextureRect = $OpponentSprite
@onready var progress_bar: TextureProgressBar = $OpponentBar/ProgressBar
@onready var name_label: Label = $OpponentBar/NameLabel
@onready var gender_texture: TextureRect = $OpponentBar/GenderTexture
@onready var level_label: Label = $OpponentBar/LevelLabel


var pokemon_to_fight : Pokemon


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
	var encounter : Encounter = Math.random_weighted(ReferenceStash.current_encounter_pool)
	pokemon_to_fight.species = encounter.species
	opponent_sprite.texture = pokemon_to_fight.species.spritesheet.get_frame_texture("Front", 0)
	name_label.text = pokemon_to_fight.species.name
	randomize()
	pokemon_to_fight.level = randi_range(encounter.minimum_level, encounter.maximum_level)
	level_label.text = str(pokemon_to_fight.level)
	
	gender_attribution()
	set_life_bar()
	
	print("You are fighting a " + pokemon_to_fight.species.name + "(Level " + str(pokemon_to_fight.level) + ")") # Temporary debug thing


func gender_attribution() -> void: #TEMPORARY
	var gender : int = randi_range(1,2)
	if gender == 1:
		pokemon_to_fight.gender = "Male"
	else:
		pokemon_to_fight.gender = "Female"
	gender_texture.texture.region.position.x = 7 * gender

func set_life_bar() -> void:
	pass
