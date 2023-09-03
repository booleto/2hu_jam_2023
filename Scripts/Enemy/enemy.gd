@tool
extends CharacterBody2D
class_name Enemy

@export var sound_detection_radius = 20
@export var hitbox_radius = 10 # bán kính hitbox <= bán kính hurtbox
@export var hurtbox_radius = 15
@export var sprite: Texture2D
@export var walk_speed: float
@export var run_speed: float

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var sprite2d : Sprite2D = $Sprite2D
@onready var visionbox : Area2D = $VisionBox
@onready var animation_tree : AnimationTree = $AnimationTree

var move_speed: float
var is_moving : bool
var sees_player : bool
var raycast_every_frame : bool = false
var raycast_target

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
			look_towards(next_pos)
			move_and_slide()
		if raycast_every_frame:
			_on_vision_box_body_entered(raycast_target)
				


func _on_navigation_agent_2d_target_reached():
	print("path reached")
	if sees_player:
		#_on_vision_box_body_exited(raycast_target)
		pass
	else:
		is_moving = false


func _on_vision_box_body_entered(body):
	if not body is Player:
		pass
	
	if raycast_vision_check(body.position):
		#print("body is player")
		is_moving = true
		nav_agent.target_position = body.position
		sees_player = true
	else:
		raycast_every_frame = true
		raycast_target = body


func _on_vision_box_body_exited(body):
	if not body is Player:
		pass
		
	if raycast_vision_check(body.position):
		is_moving = true
		nav_agent.target_position = body.position
		sees_player = false
		look_towards(body.position)
	else:
		raycast_every_frame = false
		

func look_towards(pos : Vector2):
	sprite2d.look_at(pos)
	visionbox.look_at(pos)
	
	
func raycast_vision_check(target : Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, target)
	var result = space_state.intersect_ray(query)
	
	if result.get("collider") is Player:
		return true
	return false
	
	
