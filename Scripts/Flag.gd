extends Area2D

const FINAL_LEVEL = 2


func enter_next_level():
	var name = get_tree().current_scene.name
	if name == "World":
		var _error = get_tree().change_scene("Scenes/Level1.tscn")
	elif name.begins_with("Level"):
		var level_id = int(name.substr(5))
		if level_id != FINAL_LEVEL:
			var _error = get_tree().change_scene("Scenes/Level" + str(level_id + 1) + ".tscn")


func _on_Flag_body_entered(body):
	if body.name == "Player":
		enter_next_level()
