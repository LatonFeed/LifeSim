extends Node

const MENU_SCENE = preload("res://Scenes/action_menu.tscn")
const TILE_SIZE = 128

var clicked_objects: Array = []
var active_menu = null
var last_click_world_pos: Vector2 = Vector2.ZERO

func _ready():
	active_menu = MENU_SCENE.instantiate()
	add_child(active_menu)
	active_menu.action_selected.connect(_on_menu_action_selected)

func register_click(object_that_was_clicked):
	clicked_objects.append(object_that_was_clicked)
	call_deferred("_process_clicks")

func _process_clicks():
	if clicked_objects.is_empty():
		return

	var viewport = get_viewport()
	var camera = viewport.get_camera_2d()
	if camera:
		last_click_world_pos = camera.get_global_mouse_position()
	else:
		last_click_world_pos = viewport.get_mouse_position()

	var all_actions = []
	for obj in clicked_objects:
		all_actions.append_array(obj.available_actions)
	
	if active_menu:
		active_menu.show_menu(viewport.get_mouse_position(), all_actions)
	
	clicked_objects.clear()

func _on_menu_action_selected(action_name: String):
	print("Selected: ", action_name)
	
	var grid_index_x = floor(last_click_world_pos.x / TILE_SIZE)
	
	var player = get_tree().get_first_node_in_group("Player")
	
	if player:
		player.move_to_grid_index(int(grid_index_x))
		
		if not player.movement_finished.is_connected(_execute_action_logic):
			player.movement_finished.connect(_execute_action_logic.bind(action_name), CONNECT_ONE_SHOT)
	else:
		print("Error: Player not found in group 'Player'")

func _execute_action_logic(action_name: String):
	print("Player arrived! Performing: ", action_name)
