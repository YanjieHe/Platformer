extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 500
const JUMP_HEIGHT = -820

export(int) var bottom_y = 1050

enum PlayerState { NORMAL, HURT, STAMP, ELEVATOR }

var motion = Vector2()
var player_state = PlayerState.NORMAL
var hurt_timer
var n_coins = 0
var elevator_speed = 0
var on_the_floor = false


# The player gets hurt and fails the current round
func hurt():
	if player_state != PlayerState.HURT:
		player_state = PlayerState.HURT
		hurt_timer = get_tree().create_timer(3)
		$Fail.play()

# determine if the player is at the top of the enemy
func can_step_on(collision):
	var enemy = collision.collider
	var dx = position.x - enemy.position.x
	var dy = position.y - enemy.position.y
	return (abs(dx) < 50) and (dy < -30)

# remove the enemies that the player step on
func remove_enemies(remove_list):
	for enemy_name in remove_list:
		var enemy_list = get_tree().get_nodes_in_group(enemy_name)
		if len(enemy_list) == 1:
			enemy_list[0].step_on()


func process_collision():
	if player_state == PlayerState.NORMAL:
		var remove_list = Array()
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if is_instance_valid(collision.collider):
				var name = collision.collider.name
				if name.begins_with("EnemySlime"):
					if not collision.collider.is_dead:
						if can_step_on(collision):
							remove_list.push_back(name)
						else:
							hurt()
							return
				elif name.begins_with("TrapSpikes"):
					hurt()
					return
		remove_enemies(remove_list)
		if len(remove_list) > 0:
			player_state = PlayerState.STAMP
		else:
			player_state = PlayerState.NORMAL


func is_fell_off_the_platform():
	return position.y > bottom_y

# If the player fails, restart the current level
func fail():
	var name = get_tree().current_scene.name
	var _error = get_tree().change_scene("Scenes/" + name + ".tscn")


func _physics_process(_delta):
	var friction = false
	motion.y += GRAVITY
	process_collision()

	if player_state == PlayerState.HURT:
		if abs(hurt_timer.time_left) < 0.1:
			fail()
		else:
			$AnimatedSprite.play("hurt")
	elif player_state == PlayerState.STAMP:
		$Jump.play()
		motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
		player_state = PlayerState.NORMAL
	else:
		if is_fell_off_the_platform():
			hurt()
		else:
			if Input.is_action_pressed("ui_right"):
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("walk")
			elif Input.is_action_pressed("ui_left"):
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("walk")
			else:
				$AnimatedSprite.play("idle")
				friction = true
			
			if is_on_floor() or on_the_floor:
				if is_on_floor():
					on_the_floor = true
				else:
					on_the_floor = false
				if Input.is_action_just_pressed("ui_up"):
					$Jump.play()
					motion.y = JUMP_HEIGHT
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.2)
			else:
				on_the_floor = false
				$AnimatedSprite.play("jump")
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.05)
			motion = move_and_slide(motion, UP)


func _ready():
	add_to_group("Player")
