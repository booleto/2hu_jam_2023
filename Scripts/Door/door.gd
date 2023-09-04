extends Node2D

var in_range_list = []

@onready var sound_duration : Timer = $SoundDuration


func emit_sound(body):
	if not body is Player:
		return
	sound_duration.start()
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


func _on_sound_box_body_entered(body):
	if body is Enemy:
		in_range_list.append(body)


func _on_sound_box_body_exited(body):
	if body is Enemy:
		in_range_list.erase(body)


func _on_sound_duration_timeout():
	for enemy in in_range_list:
		if enemy is Enemy:
			enemy.hearing_sounds = false
