extends Node


var turnManager : TurnManager = TurnManager.new()
var asyncTurnPool : AsyncTurnPool = AsyncTurnPool.new()


var player : CharacterBody2D

var current_map_data : MapData
var current_encounter_pool : Array[Encounter]

var current_battle_type : String
