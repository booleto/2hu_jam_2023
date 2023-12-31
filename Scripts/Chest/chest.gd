extends Area2D

signal treasure_obtained

@export var next_scene : String
@export var is_true_chest : bool
@export var treasure_sprite : Texture2D

@onready var label : Label = $Label
@onready var treasure : Sprite2D = $Treasure

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_true_chest:
		$Treasure.texture = treasure_sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if not body is Player:
		return
	if is_true_chest:
		emit_signal("treasure_obtained")
		treasure.visible = true
		$TreasureFound.play()
	else:
		$OpeningSound.play()
		label.visible = true


func _on_treasure_found_finished():
	get_tree().change_scene_to_file(next_scene)
