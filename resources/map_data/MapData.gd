extends Resource
class_name MapData


## The resource used to specify some infos about the current map (in this context, map defines
## a location in the overwolrd, not the map shown when using a Key Item such as "Town Map")
## or interacting with the maps in a Pokémon Center.


## The name of your map. Accepts formatting through BBCode.[br]
## To learn more about BBCode, go to [url]https://docs.godotengine.org/en/latest/tutorials/ui/bbcode_in_richtextlabel.html#reference[/url]
@export var name : String = "Mystery Zone"
## Wether the name of this area gets displayed when the player enters it.
@export var show_area_name : bool = false
## The BGM that plays when you enter the map. Assign a song by drag_and_dropping an audio file from [kbd]res://addons/godomon/Audio/BGM/[/kbd][br]
## If kept empty, it will keep playing the BGM from the previous map. Use the song "null.ogg" to make the BGM silent.
@export var bgm : AudioStream
## A list of sound effects played constantly while the player is on this map.
@export var sound_effects : Array[AudioStream]
## The place where your player should appear on the UI of the Town Map.[br]
## Takes a reference to a Marker2D from "MapUI.tscn".[br]
## To learn more about it, go to [url]https://godomon.fandom.com/wiki/Godomon_Wiki/Map#TownMapLocation[/url]
@export_node_path("Marker2D") var TownMapLocation
## Wether your player can fly from this map or not.
@export var can_fly : bool = true
## The items that can be dropped here using Rock Smash.[br]
## Works using the logic from Generation VI.[br]
## To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Breakable_rock#Generation_VI[/url]
@export var rock_smash_items : Resource
## The Pokémon the player can encounter here.[br]
## Unused encounter tables can be left empty.[br]
## To learn more about it, go to [url]https://godomon.fandom.com/wiki/Godomon_Wiki/Map#Encounters[/url]
@export_group("Encounters")
@export var encounter_day : Array[Encounter]
@export var encounter_night : Array[Encounter]
@export var encounter_surf : Array[Encounter]
@export var encounter_old_rod : Array[Encounter]
@export var encounter_good_rod : Array[Encounter]
@export var encounter_super_rod : Array[Encounter]
## To learn more about it, go to [url]https://godomon.fandom.com/wiki/Godomon_Wiki/Map#EncounterHeadbuttTree[/url]
@export var encounter_headbutt_tree : Array[Encounter]
## To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Breakable_rock[/url]
@export var encounter_rock_smash : Array[Encounter]
## To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Honey_Tree[/url]
@export var encounter_honey_tree : Array[Encounter]
## To learn more about it, go to [url]https://bulbapedia.bulbagarden.net/wiki/Phenomenon[/url]
@export var encounter_phenomenon : Array[Encounter]
