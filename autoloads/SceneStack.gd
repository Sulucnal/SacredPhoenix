extends Node


var stack : Array = []


func push(path : String) -> void:
	var tree : SceneTree = get_tree()
	var main : Node = tree.current_scene
	stack.append(main)
	var root : Window = tree.root
	root.remove_child(main)
	var next_scene : Node = load(path).instantiate()
	root.add_child(next_scene)
	tree.current_scene = next_scene


func pop() -> void:
	if stack.is_empty():
		return
	var tree : SceneTree = get_tree()
	var root : Window = tree.root
	tree.current_scene.queue_free()
	var previous_scene : Node = stack.pop_back()
	root.add_child(previous_scene)
	tree.current_scene = previous_scene


func clear() -> void:
	for scene in stack:
		scene.queue_free()
	stack.clear()
