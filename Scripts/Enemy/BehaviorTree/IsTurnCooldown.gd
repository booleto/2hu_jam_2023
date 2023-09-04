extends BTCondition

func tick(actor:Node, blackboard:BTBlackboard):
	if actor is Enemy:
		if actor.turn_cooldown.is_stopped():
			return BTTickResult.SUCCESS
			
	return BTTickResult.FAILURE

