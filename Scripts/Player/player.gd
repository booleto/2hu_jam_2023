extends CharacterBody2D
class_name Player

signal player_death

@export var speed = 400
@onready var animation_tree : AnimationTree = $AnimationTree

var health : int = 100
var respawns_left : int = 5

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _process(delta):
	update_animation_params()
	

func _physics_process(delta):
	get_input()
	look_at(get_global_mouse_position())
	move_and_slide()


func update_animation_params():
	if Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/player_attack"] = true
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
	else:
		animation_tree["parameters/conditions/respawning"] = false
		
	if health <= 0 and respawns_left <= 0:
		emit_signal("player_death")
		animation_tree["parameters/conditions/player_death"] = true
