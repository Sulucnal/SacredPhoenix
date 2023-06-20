extends Resource
class_name ItemQuantity


const MAX_STACK_SIZE : int = 99

@export var item : Item
@export_range(1,MAX_STACK_SIZE) var quantity : int = 1
