extends CanvasLayer

@onready var menu_background = $MenuBackground
@onready var button_list = $MenuBackground/ButtonList

func _ready():
	menu_background.visible = false

func show_menu(screen_position: Vector2, actions: Array):
	# 1 Move the menu to the mouse position
	menu_background.global_position = screen_position
	
	# 2 Clear previous
	for child in button_list.get_children():
		child.queue_free()
		
	# 3 Create a new button for each action
	for action_name in actions:
		var btn = Button.new()
		btn.text = action_name
		
		btn.pressed.connect(_on_button_clicked.bind(action_name))
		
		button_list.add_child(btn)
	
	# 4 Show the menu
	menu_background.visible = true

func _on_button_clicked(action_name):
	print("Selected action: ", action_name)
	menu_background.visible = false

func close_menu():
	menu_background.visible = false
