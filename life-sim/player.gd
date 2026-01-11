extends Node2D
class_name Player

const TILE_SIZE = 128
const WALK_SPEED = 400.0

signal movement_finished

var current_tween: Tween

func _ready() -> void:
	add_to_group("Player")
	position.x = _get_center_of_tile(floor(position.x / TILE_SIZE))

func move_to_grid_index(target_grid_index: int) -> void:
	var target_x = _get_center_of_tile(target_grid_index)
	
	if current_tween:
		current_tween.kill()
	
	var distance = abs(target_x - position.x)
	
	if distance < 1.0:
		movement_finished.emit()
		return
	
	var duration = distance / WALK_SPEED
	
	if target_x > position.x:
		scale.x = 1
	else:
		scale.x = -1
		
	current_tween = create_tween()
	current_tween.tween_property(self, "position:x", target_x, duration).set_trans(Tween.TRANS_LINEAR)
	current_tween.tween_callback(_on_arrived)

func _on_arrived():
	movement_finished.emit()

func _get_center_of_tile(grid_index: int) -> float:
	return (grid_index * TILE_SIZE) + (TILE_SIZE / 2.0)
