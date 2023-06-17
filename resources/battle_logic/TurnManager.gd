class_name TurnManager
extends Resource


enum {ALLY_TURN, ENEMY_TURN}


var turn : int = ALLY_TURN :
	get:
		return turn
	set(value):
		turn = value
		match turn:
			ALLY_TURN:
				emit_signal("ally_turn_started")
			ENEMY_TURN:
				emit_signal("ally_turn_ended")
				emit_signal("enemy_turn_started")


signal  ally_turn_started()
signal  ally_turn_ended()
signal  enemy_turn_started()


func start() -> void:
	self.turn = ALLY_TURN


func advance_turn() -> void:
	self.turn = int (self.turn + 1) & 1
