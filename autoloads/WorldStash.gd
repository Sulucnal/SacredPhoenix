extends Node


var data : Dictionary = {}


func get_id(node : Node) -> String:
	var main_node : Node = get_tree().current_scene
	return main_node.name + "_" + node.name + "_" + str(node.global_position)


func stash(id : String, key : String, value) -> void:
	data[id] = {}
	data[id][key] = value


func retrieve(id : String, key : String) -> Variant:
	if not data.has(id):
		return null
	if not data[id].has(key):
		return null
	return data[id][key]
