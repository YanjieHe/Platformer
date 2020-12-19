extends Node2D


# set the level2's background
# change the color of score to white due to the dark background
func _ready():
	$Player/ParallaxBackground/PlayerBackground.play("Level2")
	var score_label = $PlayerStatus/Score
	score_label.set("custom_colors/font_color", Color(255, 255, 255))
