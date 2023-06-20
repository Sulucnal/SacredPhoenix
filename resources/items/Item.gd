extends Resource
class_name Item


@export var name : String
@export_multiline var description : String
@export_enum("Items","Balls","Medicine","TMs","Key Items","Berries") var pocket : String
@export var texture : Texture2D
@export var infinite : bool = true
