extends Node

## A list of various constants used in the game.

#==============================================================================
#Engine
#==============================================================================

## The size of your tilemap's tiles. Used for the grid-based movements.[br]
## Don't change this unless you want to change the tilemap's tile size and know what you're doing.
const TILE_SIZE : Vector2 = Vector2(32,32)

#==============================================================================
#Player
#==============================================================================

## The max name size for a character (Pokémon and Player)
const MAX_NAME_SIZE : int = 16
## The max number of Pokémon in the player's party.
const MAX_PARTY_SIZE : int = 6
## The max amount of money a player can have.
const MAX_MONEY : int = 999999
## The max amount of casino chips a player can have.
const MAX_CASINO_CURRENCY : int = 99999
## Wether the Pokédex automatically shows up whenever the player gets a new Pokémon.
const SHOW_NEW_POKEMON_DEX_ENRTY : bool = true
## Wether the player gets a Premier ball every time they buy 10 Pokéballs or more.
const PREMIER_BALL_FOR_10_POKEBALL : bool = true
## Wether the bonus Premier Ball is given for every kind of Pokéball or only the regular one.
const PREMIER_BALL_FOR_ALL_POKEBALL : bool = false
## Wether the player gets a Premier Ball for every 10 Pokéballs bought at the same time
## (example: if the players buys 35 Pokéball, they'll get 3 Premier Balls) or a single Premier Ball
## as long as they buy more than 10 Pokéballs.
const CAN_GET_MULTIPLE_PREMIER_BALLS : bool = false
## The number of boxes available in the Pokémon Storage section of the PC.
const MAX_PC_BOXES : int = 32

#==============================================================================
#Pokémon
#==============================================================================

## The max level of a Pokémon
const MAX_LEVEL : int = 100
## The max number of attacks a Pokémon can know at once.
const MAX_ATTACK_NUMBER : int = 4
## The max value reachable by a singular EV.
const MAX_SINGULAR_EV : int = 252
## The max value reachable by the total of all the EVs.
const MAX_CUMULATED_EV : int = 508
## The basic shiny rate.
const BASE_SHINY_RATE : float = 1/4096
## The rate of shiny using the Shiny Charm.
const SHINY_CHARM_SHINY_RATE : float = 2/4096
## The odds of a Pokémon contracting the Pokérus.
const POKERUS_ODDS : float = 1/65536

#==============================================================================
#Battles
#==============================================================================

## The maximum number of turns a Pokémon can spend sleeping.
const MAX_SLEEP_TURN : int = 5
## Whether poisoned Pokémon will lose HP while walking around in the overworld.
const POISON_IN_OVERWORLD : bool = false
## Wether the Poison can make your Pokémon faint while walking in the overworld or keep them at 1 hp.
const POISON_FAINT_IN_OVERWORLD : bool = false


#==============================================================================
#Items
#==============================================================================
## Wether the TMs are single-use.
const SINGLE_USE_TM : bool = false
