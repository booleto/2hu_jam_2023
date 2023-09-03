@tool
extends CharacterBody2D
class_name Player

signal player_death
signal player_respawn

@export var speed = 400
@export var dmk_speed = 10
@export var dmk_damage = 50
@export var hitbox_radius = 10
@export var hurtbox_radius = 10
@export var footstep_radius = 20

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var fire_position : Marker2D = $FirePosition

var health : int = 100
var respawns_left : int = 5

func init_data():
	$CollisionBox.shape.radius = hitbox_radius
	$Hurtbox/Shape.shape.radius = hurtbox_radius
	$Soundbox/Shape.shape.radius = footstep_radius

func _ready():
	init_data()

# Update animation mỗi frame
func _process(_delta):
	if !Engine.is_editor_hint():
		update_animation_params()
	
# Di chuyển theo thời gian
func _physics_process(_delta):
	if !Engine.is_editor_hint():
		update_input()
		look_at(get_global_mouse_position())
		move_and_slide()
	else:
		init_data()
		

# Kiểm tra điều kiện để chỉnh animation tree
func update_animation_params():
	if Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/player_attack"] = true
		attack()
	else:
		animation_tree["parameters/conditions/player_attack"] = false
		
	if velocity != Vector2.ZERO:
		animation_tree["parameters/conditions/moving"] = true
	else:
		animation_tree["parameters/conditions/moving"] = false
		
	if health <= 0 and respawns_left > 0:
		health = 100
		respawns_left -= 1
		animation_tree["parameters/conditions/respawning"] = true
		emit_signal("player_respawn")
	else:
		animation_tree["parameters/conditions/respawning"] = false
		
	if health <= 0 and respawns_left <= 0:
		emit_signal("player_death")
		animation_tree["parameters/conditions/player_death"] = true

# Chịu sát thương
func take_damage(dmg):
	health -= dmg
	print("Took damage. Health:", health)

# Tiếng bước chân, nếu còn di chuyển thì phát tiếp
func _on_footstep_finished():
	if velocity != Vector2.ZERO: # đang đi
		$Footstep.play()

func update_input():
	# Lấy vector input người dùng để di chuyển
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	# Các thao tác phím đặc biệt
	if Input.is_action_just_pressed("activate_fairy"):
		activate_fairy()
	if Input.is_action_just_pressed("switch_fairy"):
		switch_fairy()
	if Input.is_action_just_pressed("attack"):
		attack()
	elif Input.is_action_just_pressed("danmaku"):
		danmaku()

# Kích hoạt tiên
func activate_fairy():
	pass

# Đổi tiên
func switch_fairy():
	pass

# Tấn công
func attack():
	get_parent().spawn_danmaku(fire_position.global_position, get_global_mouse_position() - position, dmk_damage, dmk_speed)

# Xài đạn mạc
func danmaku():
	pass
