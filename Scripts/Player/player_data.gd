extends Node

var hp: int = 3
const MAX_HP: int = 3

var danger: int = 0 # max là 5 (?)
const MAX_DANGER: int = 5

enum FAIRIES { BAKA, CLOWNPISS, STAR, SUNNY, LUNA }
var cooldown_times = [3, 8, 10, 8, 0]
var selected : FAIRIES
var fairy_active: bool = false
var fairies: Array = [FAIRIES.BAKA, FAIRIES.CLOWNPISS, FAIRIES.STAR, FAIRIES.SUNNY, FAIRIES.LUNA] # ⑨ -> clownpiss -> kaguya cải trang -> sunny -> luna
var uses_left: int = 4 # số lần dùng tiên còn lại

func _init():
	reset()

func _process(delta):
	if danger == MAX_DANGER:
		reset()
		get_tree().reload_current_scene()

func reset():
	hp = 3
	danger = 0
	#fairies = []
	uses_left = 4
