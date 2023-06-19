extends Control


const STARTING_Y : int = -96
const ANIMATION_DURATION : float = 1.0
const ANIMATION_WAIT : float = 3.0


@onready var texture_rect: TextureRect = $TextureRect


func animate() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(texture_rect, "position", Vector2(0,0), ANIMATION_DURATION)
	tween.tween_property(texture_rect, "position", Vector2(0,STARTING_Y), ANIMATION_DURATION).set_delay(ANIMATION_WAIT)
