extends Node

var hp: int = 3
const MAX_HP: int = 3

var danger: int = 0 # max là 5 (?)
const MAX_DANGER: int = 5

enum FAIRIES { BAKA, CLOWNPISS, STAR, SUNNY, LUNA }
var selected : FAIRIES
var fairies: Array = [] # ⑨ -> clownpiss -> kaguya cải trang -> sunny -> luna
var uses_left: int = 4 # số lần dùng tiên còn lại

func _init():
	reset()

func reset():
	hp = 3
	danger = 0
	fairies = []
	uses_left = 4
