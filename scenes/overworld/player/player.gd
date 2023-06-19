extends Moveable
class_name Player


const RUN_SPEED : float = 8.0


@onready var animation_tree: AnimationTree = $AnimationTree
@onready var anim_state : AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var raycast: RayCast2D = $RayCast2D
@onready var bump_stream_player: AudioStreamPlayer = $BumpStreamPlayer
@onready var sprite: Sprite2D = $Sprite

@onready var pause_menu: Control = $UI/PauseMenu


@export var player_data : PlayerData


var input_direction : Vector2 = Vector2.ZERO


enum PlayerState {IDLE, TURNING, WALKING, RUNNING}
enum FacingDirection {LEFT, RIGHT, UP, DOWN}


var player_state : int = PlayerState.IDLE
var facing_diretion : int = FacingDirection.DOWN
var player_skin : String
var player_skin_scepter : String = ""
var player_skin_gender : String

var last_warp_connection_id : int = -1


func _ready() -> void:
	can_move = true
	animation_tree.active = true
	set_player_skin()


func _physics_process(_delta: float) -> void:
	if can_move == true:
		if player_state == PlayerState.TURNING:
			if Input.is_action_pressed("cancel"):
				sprite.texture = load("res://assets/graphics/spritesheets/characters/players/Heros-" + player_skin + player_skin_scepter + player_skin_gender + "_run.png")
			else:
				sprite.texture = load("res://assets/graphics/spritesheets/characters/players/Heros-" + player_skin + player_skin_scepter + player_skin_gender + "_walk.png")
		elif is_moving == false:
			process_player_input()
		elif input_direction != Vector2.ZERO and !raycast.is_colliding():
			if Input.is_action_pressed("cancel"):
				sprite.texture = load("res://assets/graphics/spritesheets/characters/players/Heros-" + player_skin + player_skin_scepter + player_skin_gender + "_run.png")
				player_state == PlayerState.RUNNING
				anim_state.travel("Run")
				move(input_direction, RUN_SPEED)
			else:
				sprite.texture = load("res://assets/graphics/spritesheets/characters/players/Heros-" + player_skin + player_skin_scepter + player_skin_gender + "_walk.png")
				player_state == PlayerState.WALKING
				anim_state.travel("Walk")
				move(input_direction)
		else:
			handle_collisions()
	

func process_player_input() -> void:
	if input_direction.y == 0:
		input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if input_direction.x == 0:
		input_direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	if input_direction != Vector2.ZERO:
		animation_tree.set("parameters/Idle/blend_position", input_direction)
		animation_tree.set("parameters/Walk/blend_position", input_direction)
		animation_tree.set("parameters/Turn/blend_position", input_direction)
		animation_tree.set("parameters/Run/blend_position", input_direction)
		
		if need_to_turn():
			raycast.target_position = input_direction * GameConstants.TILE_SIZE / 2
			raycast.force_raycast_update()
			player_state = PlayerState.TURNING
			anim_state.travel("Turn")
		else:
			initial_position = position
			is_moving = true
	else:
		anim_state.travel("Idle")


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu"):
		pause_menu.animate()


func need_to_turn() -> bool:
	var new_facing_direction : int
	if input_direction.x < 0:
		new_facing_direction = FacingDirection.LEFT
	elif input_direction.x > 0:
		new_facing_direction = FacingDirection.RIGHT
	elif input_direction.y < 0:
		new_facing_direction = FacingDirection.UP
	elif input_direction.y > 0:
		new_facing_direction = FacingDirection.DOWN
	
	if facing_diretion != new_facing_direction:
		facing_diretion = new_facing_direction
		return true
	facing_diretion = new_facing_direction
	return false


func finished_turning() -> void:
	player_state = PlayerState.IDLE


func set_player_skin() -> void:
	
	match player_data.gender:
		"Male":
			player_skin = "Aranel"
			player_skin_gender = "_m"
		"Female":
			player_skin = "Viviane"
			player_skin_gender = "_f"
			
	if !player_data.has_scepter:
		player_skin_scepter = "-sans-sceptre"
		
	sprite.texture = load("res://assets/graphics/spritesheets/characters/players/Heros-" + player_skin + player_skin_scepter + player_skin_gender + "_walk.png")


func handle_collisions() -> void:
	sprite.texture = load("res://assets/graphics/spritesheets/characters/players/Heros-" + player_skin + player_skin_scepter + player_skin_gender + "_walk.png")
	anim_state.travel("Idle")
	is_moving = false
	percent_moved_to_next_tile = 0.0
	
	await get_tree().create_timer(0.2).timeout
	if input_direction != Vector2.ZERO and raycast.is_colliding():
		if !bump_stream_player.playing or bump_stream_player.get_playback_position() > 0.5:
			bump_stream_player.play()

#==================================================================================================
# Map Warping
#==================================================================================================

func warp_handler(map_transition_area : Area2D) -> void:
	if map_transition_area.new_area == null or map_transition_area.connection_id == null:
		print(map_transition_area.new_area)
		print(map_transition_area.connection_id)
		return
	last_warp_connection_id = map_transition_area.connection_id
	get_tree().paused = true
#	await Transition.slide_begin(map_transition_area.transition_direction)
	call_deferred("warp", map_transition_area.new_area)
#	Transition.slide_end(map_transition_area.transition_direction)
	get_parent().animated_sprite.play(map_transition_area.facing_position)
	get_tree().paused = false


func warp(new_area_path : String) -> void:
	MapSwapper.map_swap(self.get_parent(), new_area_path)
