extends ParentButton

# Texture size = 24*22


const ATLAS_OFFSET : int = 23

const TWEEN_DURATION : float = 0.5
const ROTATION_DEGREES : float = 30

@onready var texture_rect: TextureRect = $TextureRect
@onready var option_name: Label = $OptionName
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_focus_entered() -> void:
	super()
	texture_rect.texture.region.position.x = ATLAS_OFFSET
	animation_player.play("move")
	position.x -= 8


func _on_focus_exited() -> void:
	texture_rect.texture.region.position.x = 0
	animation_player.play("RESET")
	position.x += 8
