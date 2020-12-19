extends KinematicBody2D

func _physics_process(_delta):
	if position.y < 70:
		position.y = 15 * 70
	position.y = position.y - 1
