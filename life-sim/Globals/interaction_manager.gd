extends Node

var clicked_objects: Array = []

func register_click(object_that_was_clicked):
	clicked_objects.append(object_that_was_clicked)
	
	# Wait one frame. This allows all overlapping objects 
	# to register themselves
	call_deferred("_process_clicks")

func _process_clicks():
	if clicked_objects.is_empty():
		return

	var all_actions = []
	
	for obj in clicked_objects:
		all_actions.append_array(obj.available_actions)
	
	# Debug
	print("OPENING MENU WITH ACTIONS: ", all_actions)
	
	# TODO: UI Scene
	# show_action_menu(all_actions)

	clicked_objects.clear()
