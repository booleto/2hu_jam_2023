extends CharacterBody2D
class_name Player

signal player_death

@export var speed = 400


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(delta):
	get_input()
	look_at(get_global_mouse_position())
	move_and_slide()
