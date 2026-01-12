# Level.gd
extends Area2D

@onready var bounds_shape: CollisionShape2D = $InteractableObject/CollisionShape2D

func get_horizontal_bounds() -> Vector2:
	if not bounds_shape or not bounds_shape.shape:
		printerr("Level: No CollisionShape2D found for bounds!")
		return Vector2(-10000, 10000) # Fallback safety

	var rect = bounds_shape.shape.get_rect()
	
	var center_x = bounds_shape.global_position.x
	var half_width = rect.size.x / 2.0
	
	var min_x = center_x - half_width
	var max_x = center_x + half_width
	
	return Vector2(min_x, max_x)
