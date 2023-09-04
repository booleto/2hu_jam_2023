@tool
extends CharacterBody2D
class_name Enemy

enum State {ATTACK, ALERTED, PATROL, IDLE}

@export var health = 2
@export var sound_detection_radius = 20
@export var hitbox_radius = 10 # bán kính hitbox <= bán kính hurtbox
@export var hurtbox_radius = 15
@export var sprite: Texture2D
@export var walk_speed: float
@export var run_speed: float
@export var designated_to_alarm : bool = false
@export var designated_alarm : Alarm

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var sprite2d : Sprite2D = $Sprite2D
@onready var visionbox : Area2D = $VisionBox
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var attack_box : Area2D = $AttackBox
@onready var stun_timer : Timer = $StunTimer
@onready var effect_sprite : AnimatedSprite2D = $EffectSprite
@onready var status_sprite : Sprite2D = $StatusSprite
@onready var invul_timer : Timer = $InvulTimer
@onready var attack_delay : Timer = $AttackDelay
@onready var turn_cooldown : Timer = $TurnCooldown

var move_speed: float
var is_moving : bool
#var sees_player : bool
var player_in_view_box : bool = false
var raycast_target
var player_in_range : bool = false
var current_state = State.IDLE
var hearing_sounds : bool = false
var sound_position : Vector2
var running_to_alarm : bool

var is_stunned : bool = false
var is_marked : bool = false
var is_dead : bool = false

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
		if is_stunned:
			return
		if is_moving:
			var next_pos = nav_agent.get_next_path_position()
			var dir = to_local(next_pos).normalized()
			velocity = dir * move_speed
			look_towards(next_pos)
			move_and_slide()
			
#		if player_in_view_box:
#			if raycast_vision_check(raycast_target.position):
#				is_moving = true
#				nav_agent.target_position = raycast_target.position
#				sees_player = true
			

func _on_navigation_agent_2d_target_reached():
	is_moving = false


func _on_vision_box_body_entered(body):
	if not body is Player:
		return
	player_in_view_box = true
	raycast_target = body
	
#	if raycast_vision_check(body.position):
#		#print("body is player")
#		is_moving = true
#		nav_agent.target_position = body.position
#		sees_player = true


func _on_vision_box_body_exited(body):
	if not body is Player:
		return
	player_in_view_box = false
	#investigate_position = raycast_target.position
	
#	if raycast_vision_check(body.position):
#		is_moving = true
#		nav_agent.target_position = body.position
#		sees_player = false
#		look_towards(body.position)
#	else:
#		player_in_view_box = false
		

func look_towards(pos : Vector2):
	sprite2d.look_at(pos)
	visionbox.look_at(pos)
	attack_box.look_at(pos)
	
	
func move_towards(pos : Vector2):
	is_moving = true
	nav_agent.target_position = pos
	
	
func raycast_vision_check(target : Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, target)
	var result = space_state.intersect_ray(query)
	
	if result.get("collider") is Player:
		return true
	return false
	

func take_damage(dmg : float, mark : bool = true, stun : bool = true):
	if not invul_timer.is_stopped():
		return

	health = health - dmg
	print("enemy health:", health)
	if health <= 0:
		is_dead = true
		effect_sprite.visible = false
		status_sprite.visible = false
		animation_tree["parameters/conditions/dead"] = true
		return
		
	if mark:
		is_marked = true
	if stun:
		is_stunned = true
		effect_sprite.visible = true
		stun_timer.start()
		invul_timer.start()
		animation_tree["parameters/conditions/attacking"] = false
		animation_tree["parameters/conditions/moving"] = false


func _on_attack_box_body_entered(body):
	if body is Player:
		player_in_range = true


func _on_attack_box_body_exited(body):
	if body is Player:
		player_in_range = false



func _on_stun_timer_timeout():
	is_stunned = false
	effect_sprite.visible = false
