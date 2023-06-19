extends VBoxContainer
class_name VBoxMenu


func get_items() -> Array[Control]:
	var items : Array[Control] = []
	for child in get_children():
		if not child is Control:
			continue
		if "Heading" in child.name:
			continue
		if "Divider" in child.name:
			continue
		items.append(child)
	
	return items


func configure_focus() -> void:
	var items : Array[Control] = get_items()
	for i in items.size():
		var item : Control = items[i]
		
		item.focus_mode = Control.FOCUS_ALL
		
		item.focus_neighbor_left = item.get_path()
		item.focus_neighbor_right = item.get_path()
		
		if i == 0:
			item.focus_neighbor_top = item.get_path_to(items[items.size() - 1])
			item.focus_previous = item.get_path_to(items[items.size() - 1])
			item.grab_focus()
		else:
			item.focus_neighbor_top = items[i - 1].get_path()
			item.focus_previous = items[i - 1].get_path()
		
		if i == items.size() - 1:
			item.focus_neighbor_bottom = item.get_path_to(items[0])
			item.focus_next = item.get_path_to(items[0])
		else:
			item.focus_neighbor_bottom = items[i + 1].get_path()
			item.focus_next = items[i + 1].get_path()
