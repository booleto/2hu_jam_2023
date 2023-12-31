extends Node
class_name GameEntities

var danmaku_preload = preload("res://Scenes/Objects/Danmaku/danmaku.tscn")
var fire_effect_preload = load("res://Scenes/Objects/FireEffect/fire_effect.tscn")
var clownpiece_preload = load("res://Scenes/Objects/Clownpiece/clownpiece.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.main_stage_node = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# sinh danmaku
func spawn_danmaku(position: Vector2, direction: Vector2, damage, speed):
	var dmk_instance = danmaku_preload.instantiate()
	add_child(dmk_instance)
	dmk_instance.set_direction(direction)
	dmk_instance.position = position
	dmk_instance.speed = speed
	dmk_instance.damage = damage

func play_respawn_effect(player : Player):
	var fire_effect = fire_effect_preload.instantiate()
	add_child(fire_effect)
	fire_effect.player = player
	player.process_mode = Node.PROCESS_MODE_DISABLED

func spawn_clownpiece(pos: Vector2):
	var clownpiece = clownpiece_preload.instantiate()
	add_child(clownpiece)
	clownpiece.position = pos
