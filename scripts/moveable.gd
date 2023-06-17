extends StaticBody2D
class_name Moveable


@export var move_speed : float = 4.0

var can_move : bool = false
var is_moving : bool = false
var initial_position : Vector2 = Vector2.ZERO
var percent_moved_to_next_tile : float = 0.0


func _ready() -> void:
	initial_position = position


func move(direction : Vector2, speed_factor : float = move_speed) -> void:
	var desired_step : Vector2 = direction * GameConstants.TILE_SIZE / 2
	var current_speed : float = speed_factor
	var raycast : RayCast2D = get_node("RayCast2D")
	raycast.target_position = desired_step
	raycast.force_raycast_update()
	if !raycast.is_colliding():
		percent_moved_to_next_tile += current_speed * get_physics_process_delta_time()
		if percent_moved_to_next_tile >= 1.0:
			position = initial_position + (GameConstants.TILE_SIZE * direction)
			percent_moved_to_next_tile = 0.0
			is_moving = false
		else:
			position = initial_position + (GameConstants.TILE_SIZE * direction * percent_moved_to_next_tile)
	else:
		percent_moved_to_next_tile = 0.0
		is_moving = false
