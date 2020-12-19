extends Button


# add the "pause" button into the whitelist
func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


# show the "back to main menu" button when clicked
func _on_Pause_pressed():
	var main_menu_button = get_tree().get_nodes_in_group("MainMenu")[0]
	if get_tree().paused:
		get_tree().paused = false
		text = "Pause"
		main_menu_button.visible = false
	else:
		get_tree().paused = true
		text = "Resume"
		main_menu_button.visible = true
