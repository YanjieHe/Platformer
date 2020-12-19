extends Node2D


# set the level1's background
# change the color of score to black due to the light background
func _ready():
	$Player/ParallaxBackground/PlayerBackground.play("Level1")
	var score_label = $PlayerStatus/Score
	score_label.set("custom_colors/font_color", Color(0, 0, 0))
