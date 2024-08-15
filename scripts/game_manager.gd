extends Node

@onready var score_label = $ScoreLabel
@onready var game_over_label = $GameOverLabel

var score = 0

func add_point() -> void:
	score += 1
	if score == 1:
		score_label.text = "You collected " + str(score) + " coin."
	else:
		score_label.text = "You collected " + str(score) + " coins."
		
	if score < 3:
		game_over_label.text = "You have not collected 3/3 coins"
	else:
		game_over_label.text = "You win!"
