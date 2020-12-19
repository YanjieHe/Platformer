extends Node2D


func _on_Level1_pressed():
	get_tree().change_scene("Scenes/Level1.tscn")


func _on_Level2_pressed():
	get_tree().change_scene("Scenes/Level2.tscn")


func _on_Back_pressed():
	get_tree().change_scene("Scenes/World.tscn")
