extends Area2D
class_name Danmaku

@export var speed = 5
@export var damage = 10
var direction : Vector2 = Vector2.LEFT
var in_range_list = []

# Chỉnh hướng bay cho danmaku
func set_direction(dir : Vector2):
	direction = dir.normalized()
	
func _process(_delta):
	for enemy in in_range_list:
		if raycast_hearing_check(enemy.position):
			enemy.hearing_sounds = true
			enemy.sound_position = position
		else:
			enemy.hearing_sounds = false
			

func raycast_hearing_check(pos : Vector2):
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position, pos)
	var result = space_state.intersect_ray(query)
	var body = result.get("collider")

	if body is Enemy:
#		body.hearing_sounds = true
#		body.sound_position = position
		return true
	return false

# Đạn bay
func _physics_process(_delta):
	var velocity = direction * speed
	look_at(position + velocity)
	position = position + velocity
	
# Gọi khi đạn bay trúng vật khác
func _on_body_entered(body):
	if body is Enemy:
		body.take_damage(damage)
		pass
	
	for enemy in in_range_list:
		enemy.hearing_sounds = false
		
	queue_free()


func _on_sound_box_body_entered(body):
	if body is Enemy:
		in_range_list.append(body)


func _on_sound_box_body_exited(body):
	if body is Enemy:
		in_range_list.erase(body)
