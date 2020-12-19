extends Button


# add the "back to main menu" button into the whitelist
# hide the button
func _ready():
	add_to_group("MainMenu")
	pause_mode = Node.PAUSE_MODE_PROCESS
	visible = false

# go to the start menu
# end the pause mode
func _on_MainMenu_pressed():
	get_tree().change_scene("Scenes/World.tscn")
	get_tree().paused = false
