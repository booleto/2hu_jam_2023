extends BTAction

func tick(actor:Node, blackboard:BTBlackboard):
	if actor.raycast_vision_check(actor.raycast_target.position):
		actor.look_towards(actor.raycast_target.position)
		return BTTickResult.SUCCESS
	
	return BTTickResult.FAILURE

