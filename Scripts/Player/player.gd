extends CharacterBody2D
class_name Player

signal player_death
signal player_respawn

@export var speed = 400
@export var dmk_speed = 10
@export var dmk_damage = 50

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var fire_position : Marker2D = $FirePosition

var health : int = 100
var respawns_left : int = 5

# Lấy vector input người dùng để di chuyểm
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

# Update animation mỗi frame
func _process(delta):
	update_animation_params()
	
# Di chuyển theo thời gian
func _physics_process(delta):
	get_input()
	look_at(get_global_mouse_position())
	move_and_slide()

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

func attack():
	get_parent().spawn_danmaku(fire_position.position, get_global_mouse_position() - position, dmk_speed, dmk_damage)
