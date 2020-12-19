extends KinematicBody2D

const UP = Vector2(0, -1)

var motion = Vector2()
var timer = 3
var hidden = true
var original_pos = Vector2()

func process_collision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if is_instance_valid(collision.collider):
			if collision.collider.name == "Player":
				var player = collision.collider
				player.hurt()
				return

# Called when the node enters the scene tree for the first time.
func _ready():
	original_pos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_collision()
	timer = timer - delta
	if abs(timer) < 0.1:
		hidden = not hidden
		timer = 3
	elif abs(timer) < 1:
		motion.x = 0
		# TO DO: if the spikes collides with the player, they may not come back to their original positions
		# However, it is not a problem for now, because the player will die instantly after colliding with the spikes
		if hidden:
			motion.y = 60
		else:
			motion.y = -60

		move_and_slide(motion, UP)
