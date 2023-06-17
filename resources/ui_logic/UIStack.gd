extends Resource
class_name UIStack


var uis : Array = []


signal ui_popped(ui)
signal ui_stack_empty()

func push(ui_to_push : Control) -> void:
	if not uis.is_empty() :
		uis.back().release_focus()
	uis.append(ui_to_push)
	ui_to_push.set_focus_mode(Control.FOCUS_ALL)
	ui_to_push.show()
	ui_to_push.grab_focus()


func pop() -> Control:
	if uis.is_empty():
		return null
	var ui_to_pop : Control = uis.pop_back()
	ui_to_pop.release_focus()
	ui_to_pop.hide()
	if not uis.is_empty():
		uis.back().show()
		uis.back().grab_focus()
	ui_popped.emit(ui_to_pop)
	if uis.is_empty():
			ui_stack_empty.emit()
	return ui_to_pop


func hide_uis() -> void:
	for ui in uis:
		ui.hide()


func clear() -> void:
	hide_uis()
	uis.clear()
