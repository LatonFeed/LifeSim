extends Node

# 1. LOAD THE MENU SCENE
# This tells the manager where to find the UI scene you just built.
const MENU_SCENE = preload("res://Scenes/action_menu.tscn")

var clicked_objects: Array = []
var active_menu = null

func _ready():
	# 2. CREATE THE MENU INSTANCE
	# We create the menu immediately but keep it hidden (the menu script hides itself in _ready)
	active_menu = MENU_SCENE.instantiate()
	add_child(active_menu)

func register_click(object_that_was_clicked):
	clicked_objects.append(object_that_was_clicked)
	call_deferred("_process_clicks")

func _process_clicks():
	if clicked_objects.is_empty():
		return

	var all_actions = []
	for obj in clicked_objects:
		all_actions.append_array(obj.available_actions)
	
	# 3. CALCULATE POSITION
	# Get the mouse coordinates on the screen
	var mouse_pos = get_viewport().get_mouse_position()
	
	# 4. SHOW THE MENU
	if active_menu:
		active_menu.show_menu(mouse_pos, all_actions)
	
	clicked_objects.clear()

# if clicked the empty space
func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if active_menu and active_menu.menu_background.visible:
				print("Closing menu via global click")
				active_menu.close_menu()
