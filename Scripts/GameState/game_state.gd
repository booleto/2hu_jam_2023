extends Node

# 4 loại enum (dừng, đang chơi, thắng, thua)
enum { PAUSE, ACTIVE, WIN, LOSE }
enum { MENU, STAGE }
var current_state = ACTIVE
var current_scene = MENU

var main_stage_node # phải nhớ gán vào

signal stage_won
signal stage_lose

func _process(_delta):
	if Input.is_action_just_pressed("ui_pause") && current_scene == STAGE && current_state <= WIN:
		get_tree().paused = !get_tree().paused
		current_state = !get_tree().paused

func set_won():
	current_state = WIN
	main_stage_node.process_mode = PROCESS_MODE_DISABLED

func set_lose():
	current_state = LOSE
	main_stage_node.process_mode = PROCESS_MODE_DISABLED

func reset():
	current_state = ACTIVE
	main_stage_node.process_mode = PROCESS_MODE_INHERIT
