extends Node

var hp: int = 3
const MAX_HP: int = 3

var danger: int = 0 # max là 5 (?)
const MAX_DANGER: int = 5

var fairies: Array = [] # ⑨ -> clownpiss -> kaguya cải trang -> sunny -> luna

func _init():
    reset()

func reset():
    hp = 3
    danger = 0
    fairies = []