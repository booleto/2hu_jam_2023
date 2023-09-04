extends Area2D

@export var is_true_chest : bool
signal treasure_obtained

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if not body is Player:
		return
	if is_true_chest:
		emit_signal("treasure_obtained")
	
