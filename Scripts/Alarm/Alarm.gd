extends Area2D
class_name Alarm

signal alarm_activated

@onready var alarm_duration : Timer = $AlarmDuration

var alarmed_list = []

func activate():
	emit_signal("alarm_activated")
	alarm_duration.start()
	var overlap_bodies = get_overlapping_bodies()
	for body in overlap_bodies:
		if body is Enemy:
			body.hearing_sounds = true
			body.sound_position = position
			alarmed_list.append(body)


func _on_alarm_duration_timeout():
	for body in alarmed_list:
		body.hearing_sounds = false
