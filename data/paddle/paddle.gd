extends CharacterBody2D

@export var SPEED: int = 5
@export var NPC_SPEED: int = 2
@export var PLAYER: bool = true

var _Ball: Node2D


func _process(_delta):
	if _Ball:
		var ball_position: Vector2 = _Ball.position
		handle_npc_movement(ball_position)

	if PLAYER:
		handle_player_movement()


func handle_npc_movement(ball_position: Vector2):
	var motion = Vector2(0, 0)

	if ball_position.y <= position.y:
		motion.y -= NPC_SPEED
	elif ball_position.y >= position.y:
		motion.y += NPC_SPEED

	motion = motion.normalized() * NPC_SPEED
	move_and_collide(motion)


func handle_player_movement():
	var motion = Vector2(0, 0)

	if Input.is_action_pressed("ui_up"):
		motion.y -= SPEED
	elif Input.is_action_pressed("ui_down"):
		motion.y += SPEED

	motion = motion.normalized() * SPEED
	move_and_collide(motion)


func _on_ball_detection_body_entered(body: Node2D):
	_Ball = body


func _on_ball_detection_body_exited(_body: Node2D):
	_Ball = null
