extends Resource
class_name Encounter

## The resource used to specify which Pokémon can be encountered in a specified area,
## as well as its level and the odds of it appearing


## The species of the Pokémon to encounter
@export var species : Species
## The "weight" of the Pokémon, ie: the odds of ot appearing.\br
## The higher this number is, the more likely your Pokémon is to appear.\br
## This value [color = red]has[/color] to be positive.
@export var weight : int = 1
## The minimum level at which this Pokémon can be encountered.
@export_range(1,GameConstants.MAX_LEVEL) var minimum_level : int = 1
## The maximum level at which this Pokémon can be encountered.\br
## Need to be higher or equal to the minimum level.
@export_range(1,GameConstants.MAX_LEVEL) var maximum_level : int = 1
