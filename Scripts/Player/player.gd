@tool
extends CharacterBody2D
class_name Player

signal player_death
signal player_respawn

@export var speed = 400
@export var dmk_speed = 10
@export var dmk_damage = 1
@export var hitbox_radius = 10
@export var hurtbox_radius = 10
@export var footstep_radius = 20
@export var is_respawning : bool = false

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var fire_position : Marker2D = $FirePosition

var enemies_in_range = []

var knockback : Vector2 = Vector2.ZERO
var knockback_decay : float = 0.5

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
		update_knockback()
		move_and_slide()
	else:
		init_data()
		
# Cập nhật knockback
func update_knockback():
	if knockback.length() < 5:
		knockback = Vector2.ZERO
		return
	knockback = knockback * knockback_decay

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

	animation_tree["parameters/conditions/respawning"] = false

# Tiếng bước chân, nếu còn di chuyển thì phát tiếp
func _on_footstep_finished():
	if velocity != Vector2.ZERO: # đang đi
		$Footstep.play()

func update_input():
	# Lấy vector input người dùng để di chuyển
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed + knockback
	
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
	animation_tree["parameters/conditions/player_attack"] = true
	for enemy in enemies_in_range:
		enemy.take_damage(1, false)
		if enemy.is_marked:
			PlayerData.hp += 1
			enemy.is_marked = false
			print("recovered. Health: ", PlayerData.hp)

# Xài đạn mạc
func danmaku():
	take_damage(1, Vector2.ZERO)
	get_parent().spawn_danmaku(fire_position.global_position, get_global_mouse_position() - position, dmk_damage, dmk_speed)

# Chịu sát thương
func take_damage(dmg: float, knockback_dir: Vector2, knockback_force: float = 5000, decay : float = 0.5):
	if is_respawning:
		return
	
	PlayerData.hp -= dmg
	if PlayerData.hp <= 0 and PlayerData.danger < PlayerData.MAX_DANGER:
		emit_signal("player_respawn")
		PlayerData.hp = PlayerData.MAX_HP
		PlayerData.danger += 1
		animation_tree["parameters/conditions/respawning"] = true
		get_parent().play_respawn_effect(self)
		print("respawn. Alarm: ", PlayerData.danger)
		
	if PlayerData.hp <= 0 and PlayerData.danger >= PlayerData.MAX_DANGER:
		print("player lost")
		emit_signal("player_death")
		animation_tree["parameters/conditions/player_death"] = true
		GameState.set_lose()
		
	print("player took dmg. Health: ", PlayerData.hp)
	knockback = knockback_dir * knockback_force
	knockback_decay = decay


func _on_hitbox_body_entered(body):
	if body is Enemy:
		print("enemy in range")
		enemies_in_range.append(body)


func _on_hitbox_body_exited(body):
	if body is Enemy:
		enemies_in_range.erase(body)


