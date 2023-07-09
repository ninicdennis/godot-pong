extends Node2D

@export var PLAYER_SCORE: int = 0
@export var NPC_SCORE: int = 0

@onready var _PlayerScore = $UI/PlayerScore
@onready var _NPCScore = $UI/NPCScore
@onready var _ScoreText = $UI/ScoreText
@onready var _PlayAgainButton = $UI/PlayAgainButton
@onready var _QuitButton = $UI/QuitButton

@onready var _PaddlePlayer = $Players/PaddlePlayer
@onready var _PaddleNPC = $Players/PaddleNPC
@onready var _Ball = $Players/Ball

@onready var _ResetTimer = $ResetTimer


func _ready():
	set_score()
	_ScoreText.text = ""


func set_score():
	_PlayerScore.text = str(PLAYER_SCORE)
	_NPCScore.text = str(NPC_SCORE)


func update_scores(winner: String):
	set_score()
	if PLAYER_SCORE == 7:
		_ScoreText.text = "Player Wins!"
		toggle_endgame_buttons(true)
	elif NPC_SCORE == 7:
		_ScoreText.text = "NPC Wins!"
		toggle_endgame_buttons(true)
	else:
		_ScoreText.text = winner.capitalize() + " Scores"
		_ResetTimer.start()


func toggle_endgame_buttons(toggle: bool):
	_PlayAgainButton.visible = toggle
	_QuitButton.visible = toggle


func reset_positions():
	_ScoreText.text = ""
	_PaddlePlayer.position.y = 120
	_PaddleNPC.position.y = 120
	_Ball.position = Vector2(240, 120)


func _on_player_goal_body_entered(_body: Node2D):
	NPC_SCORE += 1
	update_scores("npc")


func _on_npc_goal_body_entered(_body: Node2D):
	PLAYER_SCORE += 1
	update_scores("player")


func _on_reset_timer_timeout():
	reset_positions()


func _on_play_again_button_pressed():
	get_tree().reload_current_scene()


func _on_quit_button_pressed():
	get_tree().quit()
