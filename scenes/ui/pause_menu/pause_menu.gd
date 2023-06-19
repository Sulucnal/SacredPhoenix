extends Control


@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var v_box_container: VBoxContainer = $ButtonsContainer/VBoxContainer
@onready var trainer_card_button: Button = $ButtonsContainer/VBoxContainer/TrainerCardButton


var is_in_menu : bool = false
var option_index : int


func animate() -> void:
	if visible == false:
		set_card_name()
		get_tree().paused = true
		animation.play("animation")
		visible = true
		await animation.animation_finished
		v_box_container.configure_focus()
		option_index = 1
		is_in_menu = true
		


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("menu") and is_in_menu == true:
		is_in_menu = false
		animation.play_backwards("animation")
		await animation.animation_finished
		visible = false
		get_tree().paused = false


func set_card_name() -> void:
	var player_name : String = get_parent().get_parent().player_data.name
	if player_name != null:
		trainer_card_button.option_name.text = player_name
