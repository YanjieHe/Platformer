extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 50
const JUMP_HEIGHT = -800

# if the player passes the line, activate the enemy
export (int) var thaw_x = 0

var motion = Vector2()
var last_pos = Vector2()
var move_left = true
var is_freezed = true
var is_dead = false
var dead_timer: SceneTreeTimer = null


func get_player():
	return get_tree().get_nodes_in_group("Player")[0]


func process_collision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if is_instance_valid(collision.collider):
			if collision.collider.name == "Player":
				var player = collision.collider
				if not player.can_step_on(collision):
					player.hurt()
					return


func _physics_process(_delta):
	if is_dead:
		$AnimatedSprite.play("dead")
		if abs(dead_timer.time_left) <= 0.1:
			queue_free()
	else:
		process_collision()
		if is_freezed:
			var player_instance = get_player()
			if player_instance.position.x > thaw_x:
				is_freezed = false
		else:
			motion.y += GRAVITY
			if move_left:
				motion.x = -SPEED
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("walk")
			else:
				motion.x = SPEED
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("walk")
			motion = move_and_slide(motion, UP)
			if position.distance_squared_to(last_pos) >= 0.01:
				last_pos = position
			else:
				move_left = not move_left


func step_on():
	is_dead = true
	dead_timer = get_tree().create_timer(3)
	# move the dead enemy lower to put it on the ground
	$AnimatedSprite.offset.y = 28


func _ready():
	add_to_group(name)
