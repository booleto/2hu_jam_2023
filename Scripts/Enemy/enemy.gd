@tool
extends CharacterBody2D

@export var sound_detection_radius = 20
@export var hitbox_radius = 10 # bán kính hitbox <= bán kính hurtbox
@export var hurtbox_radius = 15
@export var sprite: Texture2D

func set_data():
	$Soundbox/Area.shape.radius = sound_detection_radius
	$Hitbox.shape.radius = hitbox_radius
	$Hurtbox/Shape.shape.radius = hurtbox_radius
	$Sprite.texture = sprite

func _ready():
	set_data()

func _physics_process(_delta):
	if Engine.is_editor_hint():
		set_data()
