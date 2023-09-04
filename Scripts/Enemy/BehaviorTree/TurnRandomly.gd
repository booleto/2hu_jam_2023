extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	var rotation_theta = randf_range(0, 2*PI)
	actor.look_towards(actor.position + Vector2(cos(rotation_theta), sin(rotation_theta)))
	actor.turn_cooldown.start()
	return BTTickResult.SUCCESS

