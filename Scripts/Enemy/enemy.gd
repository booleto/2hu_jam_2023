@tool
extends CharacterBody2D

@export var sound_detection_radius = 20
@export var hitbox_radius = 10 # bán kính hitbox <= bán kính hurtbox
@export var hurtbox_radius = 15
@export var sprite: Texture2D
@export var move_speed: float

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var sprite2d : Sprite2D = $Sprite2D
@onready var visionbox : Area2D = $VisionBox
var is_moving: bool

func set_data():
	$Soundbox/Area.shape.radius = sound_detection_radius
	$Hitbox.shape.radius = hitbox_radius
	$Hurtbox/Shape.shape.radius = hurtbox_radius
	#$Sprite.texture = sprite

func _ready():
	set_data()
	nav_agent.max_speed = 99999

func _physics_process(_delta):
	if Engine.is_editor_hint():
		set_data()
	else:
		if is_moving:
			var next_pos = nav_agent.get_next_path_position()
			var dir = to_local(next_pos).normalized()
			velocity = dir * move_speed
			sprite2d.look_at(next_pos)
			visionbox.look_at(next_pos)
			move_and_slide()


func _on_navigation_agent_2d_target_reached():
	is_moving = false


func _on_vision_box_body_entered(body):
	if body is Player:
		print("body is player")
		is_moving = true
		nav_agent.target_position = body.position


func _on_vision_box_body_exited(body):
	if body is Player:
		is_moving = true
		nav_agent.target_position = body.position
