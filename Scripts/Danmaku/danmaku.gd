extends Area2D
class_name Danmaku

@export var speed = 5
@export var damage = 20
var direction : Vector2 = Vector2.LEFT

# Chỉnh hướng bay cho danmaku
func set_direction(dir : Vector2):
	direction = dir.normalized()

# Đạn bay
func _physics_process(delta):
	var velocity = direction * speed
	position = position + velocity

# Gọi khi đạn bay trúng vật khác
func _on_body_entered(body):
	if body is Player:
		body.take_damage(damage)
	queue_free()
