extends Node
class_name Math


func random_weighted(list_to_sort : Array) -> Variant:
	var total_weight : int = 0
	for i in range(list_to_sort.size()):
		total_weight += list_to_sort[i].weight
	
	randomize()
	var random_value : int = randi_range(0, total_weight)
	var incrementer : int = 0
	var current_weight : int = list_to_sort[0].weight
	while random_value > current_weight:
		incrementer += 1
		current_weight += list_to_sort[incrementer].weight
	
	return list_to_sort[incrementer]
