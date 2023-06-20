extends Resource
class_name Pokemon

## The resource used to define individual Pokémon.
## @tutorial: https://godomon.fandom.com/wiki/Godomon_Wiki/Pokemon

## The species of a Pokémon. Drag and drop a file from [kbd]res://addons/godomon/Resources/Species/(potential_gen_file)[/kbd].
@export_group("General")
@export var species : Species # Write a setter to modify the values affected by this one when it's modified.
@export var nickname : String = ""
@export_range(1,100) var level : int = 5
@export var experience : int = 0
@export var ability : Resource # Replace with an "ability" resource once it's done.
@export_enum("Male","Female","None","Random") var gender : String = "Random"
## For a list of the nature's and their effects, go to [url]https://bulbapedia.bulbagarden.net/wiki/Nature#List_of_Natures[/url]
@export_enum("Random","Hardy","Lonely","Brave","Adamant","Naughty","Bold","Docile","Relaxed","Impish","Lax","Timid","Hasty","Serious","Jolly","Naive","Modest","Mild","Quiet","Bashful","Rash","Calm","Gentle","Sassy","Careful","Quirky") var nature : String = "Random"
@export var is_shiny : bool = false
## A virus that affects the ability of a Pokémon to earn extra EVs after defeating a Pokémon.[br]
## To learn more about the Pokérus, go to [url]https://bulbapedia.bulbagarden.net/wiki/Pok%C3%A9rus[/url]
@export var has_pokerus : bool = false
## Whether the Pokémon already had the Pokérus or not.[br]
## A Pokémon who have already contracted the Pokérus can't have it again.
@export var had_pokerus : bool = false

@export_group("Stats")
## If this value is set to -1, the Pokémon will have all of its hp.
@export_range(-1,999) var current_hp : int = -1
@export_range(1,999) var max_hp : int = calculate_random_stat("max_hp")
@export_range(1,999) var attack : int = calculate_random_stat("attack")
@export_range(1,999) var defense : int = calculate_random_stat("defense")
@export_range(1,999) var special_attack : int = calculate_random_stat("special_attack")
@export_range(1,999) var special_defense : int = calculate_random_stat("special_defense")
@export_range(1,999) var speed : int = calculate_random_stat("speed")
@export_range(0,255) var hapiness : int = 0
@export_enum("None", "Sleep", "Poison", "StrongPoison", "Burn", "Paralysis", "Frozen") var status : String = "None"
## The number of turns remaining before the Pokémon stops sleeping.
@export_range(0,GameConstants.MAX_SLEEP_TURN) var sleep_turns : int = 0
## If this value is above 0, the Pokémon will be an egg and the value will correspond to the steps to hatch.[br]
## set to -1 to automatically set this value to the maximum for this species.
@export var step_to_hatch : int = 0:
	set(value):
		if value == -1:
			value = species.hatch_steps * species.egg_cycles
		step_to_hatch = value
@export var moves : Array[Resource] # Replace with a "move" resource once it's done.
@export var pokeball : Resource # Replace with a "pokeball" resource once it's done.
@export var held_item : Resource # Replace with an "item" resource once it's done.

@export_group("EVs and IVs")

@export_range(0,255) var pokerus : int = 0

@export_subgroup("EVs") # Make a function to make sure that the sum can't exceed GameConstants.MAX_CUMULATED_EV
@export_range(0,GameConstants.MAX_SINGULAR_EV) var ev_hp : int = randi_range(0,GameConstants.MAX_SINGULAR_EV)
@export_range(0,GameConstants.MAX_SINGULAR_EV) var ev_attack : int = randi_range(0,GameConstants.MAX_SINGULAR_EV)
@export_range(0,GameConstants.MAX_SINGULAR_EV) var ev_defense : int = randi_range(0,GameConstants.MAX_SINGULAR_EV)
@export_range(0,GameConstants.MAX_SINGULAR_EV) var ev_special_attack : int = randi_range(0,GameConstants.MAX_SINGULAR_EV)
@export_range(0,GameConstants.MAX_SINGULAR_EV) var ev_special_defense : int = randi_range(0,GameConstants.MAX_SINGULAR_EV)
@export_range(0,GameConstants.MAX_SINGULAR_EV) var ev_speed : int = randi_range(0,GameConstants.MAX_SINGULAR_EV)

@export_subgroup("IVs")
@export_range(0,31) var _hp : int = randi_range(0,31)
@export_range(0,31) var iv_attack : int = randi_range(0,31)
@export_range(0,31) var iv_defense : int = randi_range(0,31)
@export_range(0,31) var iv_special_attack : int = randi_range(0,31)
@export_range(0,31) var iv_special_defense : int = randi_range(0,31)
@export_range(0,31) var iv_speed : int = randi_range(0,31)

@export_group("ContestStats")
@export_range(0,255) var beauty : int = randi_range(0, 255)
@export_range(0,255) var cool : int = randi_range(0, 255)
@export_range(0,255) var cute : int = randi_range(0, 255)
@export_range(0,255) var smart : int = randi_range(0, 255)
@export_range(0,255) var tough : int = randi_range(0, 255)
@export_range(0,255) var sheen : int = randi_range(0, 255)

@export_group("Markings")
@export var has_marking_circle : bool = false
@export var has_marking_triangle : bool = false
@export var has_marking_square : bool = false
@export var has_marking_heart : bool = false
@export var has_marking_star : bool = false
@export var has_marking_diamond : bool = false

@export_group("OwnerInfos")
@export var owner : Resource # Replace with a "trainer" resource once it's done and write a setter to modify the values below when owner is modified.
#@export var owner_id : int = owner.id
#@export var owner_name : String = owner.name
#@export var owner_gender : String = owner.gender
#@export var owner_language : String = owner.language

@export_group("Misc")
@export var ribbons : Array[Resource] = [] # Replace with a "ribbon" resource once it's done.
@export var id : int = randi()

@export_group("Obtention")
@export var obtain_method : String
@export var obtain_map : String
@export var obtain_level : int = level
@export var hatched_map : String
@export var language : String


func calculate_random_stat(state_name : String) -> int:
	var current_nature : String = nature
	var state_to_modify : int
	match state_name:
		"max_hp":
			state_to_modify = max_hp
		"attack":
			state_to_modify = attack
		"defense":
			state_to_modify = defense
		"special_attack":
			state_to_modify = special_attack
		"special_defense":
			state_to_modify = special_defense
		"speed":
			state_to_modify = speed
		
	return 10 # temporary placeholder
