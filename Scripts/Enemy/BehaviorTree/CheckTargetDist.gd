extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.position.distance_to(actor.sound_position) > 150:
		return BTTickResult.SUCCESS
	
	actor.look_towards(actor.sound_position)
	return BTTickResult.FAILURE
