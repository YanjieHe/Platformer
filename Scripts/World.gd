extends Node2D


func _on_LevelChooser_pressed():
	get_tree().change_scene("Scenes/ChooseLevel.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("Scenes/Credits.tscn")
