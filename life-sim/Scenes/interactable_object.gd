extends Area2D

@export var available_actions: Array[String] = []

func _ready() -> void:
	input_pickable = true


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("Clicked on: ", name)
			InteractionManager.register_click(self)
